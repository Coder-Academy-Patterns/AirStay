# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

host_user = User.create!(
  email: 'host@example.com',
  password: 'ABCDEF123',
  password_confirmation: 'ABCDEF123'
)
Profile.create!(
  user: host_user,
  first_name: 'Example',
  last_name: 'Host'
)

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
  Listing.create!(
    host: host_user,
    region: region,
    address: region.address
  )
end
