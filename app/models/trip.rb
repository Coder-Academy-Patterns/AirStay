class Trip < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :listing

  class CheckedDatesValidator < ActiveModel::Validator
    def validate(record)
      attributes = options.fetch(:attributes)
      start_date = record[attributes[0]]
      end_date = record[attributes[1]]
      record.errors.add(:base, "#{attributes[0]} must be earlier than #{attributes[1]}") unless start_date < end_date
    end
  end

  validates :check_in_date, :check_out_date, overlap: { exclude_edges: [:check_in_date, :check_out_date] }, checked_dates: true
  validates :stripe_charge_id, presence: true

  scope :with_listing, -> (listing) { where(listing: listing) }
  scope :out_after_date, -> (date) { where('check_out_date >= ?', date) }
  scope :in_before_date, -> (date) { where('check_in_date < ?', date) }

  def nights_count
    (check_out_date - check_in_date).to_i
  end
end

class Trip
  def self.available_date_ranges_for_listing(listing, days_ahead, start_date)
    end_date = start_date + days_ahead
    trips = self.with_listing(listing).out_after_date(start_date).in_before_date(end_date)

    prev_end_date = nil
    available_dates = trips.reduce([]) do |available_dates, trip|
      available_dates << Range.new(prev_end_date, trip.check_in_date, true) if prev_end_date
      prev_end_date = trip.check_out_date
      available_dates
    end

    available_dates << Range.new(prev_end_date, end_date, true) if prev_end_date
    available_dates << Range.new(start_date, end_date, true) if available_dates.empty?

    available_dates
  end

  def self.earliest_available_date_for_listing(listing, days_ahead, start_date)
    date_ranges = available_date_ranges_for_listing(listing, days_ahead, start_date)
    date_ranges.first.try(:min)
  end
end

class Trip
  class Cost
    attr_reader :fee_to_night_counts  

    def initialize(check_in_date, check_out_date)
      @service_fee_cents = Listing.service_fee_cents
      @nights = []
      @fee_to_night_counts = Hash.new(0)

      check_in_date.step(check_out_date - 1) do |date|
        provision = ListingProvision.for_date(date)
        @cleaning_fee_cents = provision.cleaning_fee_cents if date == check_in_date  
        @nights << provision.nightly_fee_cents
        @fee_to_night_counts[provision.nightly_fee_cents] += 1 
      end
    end

    def total_nights_cents
      @fee_to_night_counts.each_pair.map{ |fee, count| fee * count }.reduce(0, :+)
    end

    def total_cents
      @service_fee_cents + @cleaning_fee_cents + total_nights_cents
    end

    def cleaning_fee
      Money.new(@cleaning_fee_cents)
    end

    def service_fee
      Money.new(@service_fee_cents)
    end

    def total
      Money.new(total_cents)
    end
  end

  def cost
    Cost.new(check_in_date, check_out_date)
  end

  def total_cents
    total_cents = Listing.service_fee_cents

    check_in_date.step(check_out_date - 1) do |date|
      provision = ListingProvision.for_date(date)
      total_cents += provision.cleaning_fee_cents if date == check_in_date  
      total_cents += provision.nightly_fee_cents
    end

    total_cents
  end

  monetize :total_cents
end
