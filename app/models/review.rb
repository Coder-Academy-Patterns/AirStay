class Review < ApplicationRecord
  belongs_to :trip
  
  validates :from_guest, inclusion: [true, false]

  scope :for_host, -> (host) { joins(trips: [:locations]).where(user: host) }
  scope :for_guest, -> (guest) { joins(:trips).where(guest: guest) }
end
