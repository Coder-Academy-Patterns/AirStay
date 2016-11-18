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

  scope :with_listing, -> (listing) { where(listing: listing) }
  scope :out_after_date, -> (date) { where('check_out_date >= ?', date) }
  scope :in_before_date, -> (date) { where('check_in_date < ?', date) }

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
