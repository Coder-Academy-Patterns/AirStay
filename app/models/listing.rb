class Listing < ApplicationRecord
  belongs_to :host, class_name: 'User'
  belongs_to :region

  validates :address, presence: true

  geocoded_by :address, latitude: :lat, longitude: :lng
  after_validation :geocode

  def region_country_code_upper
    region.try(:country_code).try(:upcase)
  end

  def city_name
    region.try(:name)
  end

  def street
    # Remove city and country
    address.try { |address| address.split(',').reverse.drop(2).map(&:strip).reverse.join(', ') }
  end
end

class Listing
  def available_date_ranges(days_ahead, start_date)
    Trip.available_date_ranges_for_listing(self, days_ahead, start_date)
  end

  def earliest_available_date(days_ahead = 30)
    @earliest_date_available ||= Trip.earliest_available_date_for_listing(self, days_ahead, Date.today)
  end
end
