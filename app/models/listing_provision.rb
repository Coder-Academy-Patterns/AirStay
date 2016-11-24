class ListingProvision < ApplicationRecord
  belongs_to :listing

  before_validation :set_defaults
  validates :guests_max, inclusion: { in: 1..50 }, presence: true
  validates :bedroom_count, inclusion: { in: 1..50 }, presence: true
  validates :bed_count, inclusion: { in: 1..50 }, presence: true
  validates :nights_min, inclusion: { in: 1..60 }, presence: true
  validates :nightly_fee_cents, numericality: { greater_than_or_equal_to: 1 }, presence: true
  validates :cleaning_fee_cents, numericality: { greater_than_or_equal_to: 0 }, presence: true

  scope :by_listing, -> (listing) { where(listing: listing) }
  scope :oldest_to_youngest, -> { order(start_date: :asc) }
  scope :starting_from, -> (date) { where('start_date <= ?', date).order(start_date: :desc) }

  def self.for_date(date)
    starting_from(date).limit(1).first
  end

  monetize :nightly_fee_cents
  monetize :cleaning_fee_cents

  private
    def set_defaults
      self.cleaning_fee_cents = 0 if self.cleaning_fee_cents.nil?
    end
end

# class ListingProvision
#   def self.route_key
#     'provisions'
#   end

#   def self.singular_route_key
#     'provision'
#   end

#   def model_name
#     ActiveModel::Name.new(
#       self.class,
#       nil,
#       'provision'
#     )
#   end
# end
