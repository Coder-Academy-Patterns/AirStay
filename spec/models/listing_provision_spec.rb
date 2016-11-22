require 'rails_helper'

RSpec.describe ListingProvision, type: :model do
  let(:host) { User.create!(email: 'host@example.com', password: 'ABCDEF123', password_confirmation: 'ABCDEF123') }
  let(:region) { Region.create!(name: 'Victoria', country_code: 'au') }
  let(:listing) { Listing.create!(host: host, region: region, address: region.address) }

  it 'should allow valid values' do
    expect(ListingProvision.new(listing: listing, start_date: Date.today, guests_max: 3, bedroom_count: 2, bed_count: 3, nights_min: 3, nightly_fee_cents: 140, cleaning_fee_cents: 20)).to be_valid
    expect(ListingProvision.new(listing: listing, start_date: Date.new(2001), guests_max: 1, bed_count: 1, nightly_fee_cents: 10, cleaning_fee_cents: 0)).to be_valid
    expect(ListingProvision.new(listing: listing, start_date: Date.new(2001), guests_max: 1, bed_count: 1, nightly_fee_cents: 1)).to be_valid
  end

  it 'should disallow invalid values' do
    attributes = { listing: listing, start_date: Date.today, guests_max: 3, bedroom_count: 2, bed_count: 3, nights_min: 3, nightly_fee_cents: 140, cleaning_fee_cents: 20 }
    expect(ListingProvision.new(attributes.reject{ |key, value| key == :listing })).to_not be_valid
    expect(ListingProvision.new(attributes.merge({ bed_count: 0 }))).to_not be_valid
    expect(ListingProvision.new(attributes.merge({ nights_min: 0 }))).to_not be_valid
    expect(ListingProvision.new(attributes.reject{ |key, value| key == :nights_min })).to be_valid
    expect(ListingProvision.new(attributes.reject{ |key, value| key == :cleaning_fee_cents })).to be_valid
  end

  it 'should use provision from correct day' do
    listing1 = ListingProvision.create(listing: listing, start_date: Date.today, guests_max: 1, bedroom_count: 1, bed_count: 1, nights_min: 1, nightly_fee_cents: 100, cleaning_fee_cents: 20)
    listing2 = ListingProvision.create(listing: listing, start_date: Date.today + 3, guests_max: 3, bedroom_count: 2, bed_count: 3, nights_min: 3, nightly_fee_cents: 100, cleaning_fee_cents: 20)
    expect(ListingProvision.by_listing(listing).starting_from(Date.today - 1)).to be_empty
    expect(ListingProvision.by_listing(listing).starting_from(Date.today)).to eq([listing1])
    expect(ListingProvision.by_listing(listing).starting_from(Date.today + 1)).to eq([listing1])
    expect(ListingProvision.by_listing(listing).starting_from(Date.today + 2)).to eq([listing1])
    expect(ListingProvision.by_listing(listing).starting_from(Date.today + 3)).to eq([listing2, listing1])
    expect(ListingProvision.by_listing(listing).starting_from(Date.today + 4)).to eq([listing2, listing1])
  end
end
