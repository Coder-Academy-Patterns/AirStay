class Listing < ApplicationRecord
  belongs_to :host, class_name: 'User'
  belongs_to :region

  validates :address, presence: true

  geocoded_by :address, latitude: :lat, longitude: :lng
  after_validation :geocode
end
