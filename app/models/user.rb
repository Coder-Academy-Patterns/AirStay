class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_one :profile
end

class User
  has_many :trips, foreign_key: :guest_id
  has_many :authored_reviews, through: :trips, source: :reviews
  has_many :reviews_as_guest, -> { where(from_guest: true) }, through: :trips, source: :reviews, class_name: 'Review'
  has_many :reviews_from_hosts, -> { where(from_guest: false) }, through: :trips, source: :reviews, class_name: 'Review'

  has_many :listings, foreign_key: :host_id
  has_many :hosted_trips, through: :listings, source: :trips, class_name: 'Trip'
  has_many :reviews_from_guests, -> { where(from_guest: true) }, through: :hosted_trips, source: :reviews, class_name: 'Review'
  has_many :reviews_as_host, -> { where(from_guest: false) }, through: :hosted_trips, source: :reviews, class_name: 'Review'
end
