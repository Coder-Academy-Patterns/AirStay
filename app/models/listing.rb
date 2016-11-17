class Listing < ApplicationRecord
  belongs_to :host, class_name: 'User'
  belongs_to :region

  validates :address, presence: true

  geocoded_by :address, latitude: :lat, longitude: :lng
  after_validation :geocode

  def region_country_code_upper
    region.try(:country_code).try(:upcase)
  end

  def region_city
    region.try(:name)
  end

  def street
    # Remove city and country
    address.try { |address| address.split(',').reverse.drop(2).map(&:strip).reverse.join(', ') }
  end
end
