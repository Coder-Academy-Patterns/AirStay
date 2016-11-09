class Profile < ApplicationRecord
  belongs_to :user
  # User must enter these required fields
  validates :first_name, presence: true
  validates :last_name, presence: true
end
