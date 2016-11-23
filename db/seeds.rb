# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# host_user = User.create!(
#   email: 'host@example.com',
#   password: 'ABCDEF123',
#   password_confirmation: 'ABCDEF123'
# )
# Profile.create!(
#   user: host_user,
#   first_name: 'Example',
#   last_name: 'Host'
# )

users = 5.times.map do
  password = Faker::Internet.password
  user = User.create!(
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password
  )
  profile = Profile.create!(
    user: user,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  user
end

Region.create!([
  { name: 'Melbourne', country_code: 'au' },
  { name: 'Sydney', country_code: 'au' },
  { name: 'Brisbane', country_code: 'au' },

  { name: 'New York', country_code: 'us' },
  { name: 'Los Angeles', country_code: 'us' },
  { name: 'Chicago', country_code: 'us' },

  { name: 'Paris', country_code: 'fr' },
  { name: 'Nice', country_code: 'fr' },
  { name: 'Marseille', country_code: 'fr' },

  { name: 'Berlin', country_code: 'de' },
  { name: 'Munich', country_code: 'de' },
  { name: 'Cologne', country_code: 'de' },

  { name: 'Tokyo', country_code: 'jp' },
  { name: 'Kyoto', country_code: 'jp' },
  { name: 'Osaka', country_code: 'jp' },

  { name: 'Wellington', country_code: 'nz' },
  { name: 'Auckland', country_code: 'nz' },
  { name: 'Queenstown', country_code: 'nz' }
]) do |region|
  listing = Listing.create!(
    host: users.sample,
    region: region,
    address: region.address
  )
  guest_max_count = Random.rand(1..4)
  listing_provision = ListingProvision.create!(
    listing: listing,
    start_date: Date.new(2001),
    guests_max: guest_max_count,
    bed_count: Random.rand(1..guest_max_count),
    nights_min: Random.rand(1..3),
    nightly_fee_cents: Random.rand(60_00..200_00).round(-2),
    cleaning_fee_cents: Random.rand(20_00..50_00).round(-2)
  )

  start_date = Date.today - 100
  trip_gap = 6
  3.times do |n|
    trip = Trip.create!(
      listing: listing,
      guest: users.reject{ |u| u == listing.host }.sample,
      check_in_date: start_date + (n * trip_gap),
      check_out_date: start_date + (n * trip_gap) + Random.rand(1...trip_gap),
      stripe_charge_id: 'sample'
    )
    review_from_guest = Review.create!(
      trip: trip,
      content: Faker::Hipster.paragraph(1, true, 4),
      rating: Random.rand(1..5),
      from_guest: false
    )
    review_from_host = Review.create!(
      trip: trip,
      content: Faker::Hipster.paragraph(1, true, 4),
      rating: Random.rand(1..5),
      from_guest: true
    )
  end
end
