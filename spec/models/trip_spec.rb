require 'rails_helper'

RSpec.describe Trip, type: :model do
  let(:host) do
    User.create!(
      email: 'host@example.com',
      password: 'ABCDEF123',
      password_confirmation: 'ABCDEF123'
    )
  end

  let(:region) do
    Region.create!(
      name: 'Melbourne',
      country_code: 'au'
    )
  end

  let(:listing) do
    Listing.create!(
      host: host,
      region: region,
      address: region.address
    )
  end

  let(:guest) do
    User.create!(
      email: 'guest@example.com',
      password: 'ABCDEF123',
      password_confirmation: 'ABCDEF123'
    )
  end

  it "should be valid" do
    trip = Trip.new(
      guest: guest,
      listing: listing,
      check_in_date: Date.today,
      check_out_date: Date.today + 3
    )
    expect(trip).to be_valid
  end

  it "should disallow same check in and out dates" do
    trip = Trip.new(
      guest: guest,
      listing: listing,
      check_in_date: Date.today,
      check_out_date: Date.today
    )
    expect(trip).to_not be_valid
  end

  it "should disallow later check in to check out" do
    trip = Trip.new(
      guest: guest,
      listing: listing,
      check_in_date: Date.today + 1,
      check_out_date: Date.today
    )
    expect(trip).to_not be_valid
  end

  it "should disallow overlapping trips" do
    Trip.create!(
      guest: guest,
      listing: listing,
      check_in_date: Date.today,
      check_out_date: Date.today + 3
    )

    # Same dates is invalid
    expect(Trip.new(
      guest: guest,
      listing: listing,
      check_in_date: Date.today,
      check_out_date: Date.today + 3
    )).to_not be_valid

     # Larger date range is invalid
    expect(Trip.new(
      guest: guest,
      listing: listing,
      check_in_date: Date.today - 5,
      check_out_date: Date.today + 5
    )).to_not be_valid

    # Start of trip is invalid
    expect(Trip.new(
      guest: guest,
      listing: listing,
      check_in_date: Date.today,
      check_out_date: Date.today + 1
    )).to_not be_valid

    # End of trip is invalid
    expect(Trip.new(
      guest: guest,
      listing: listing,
      check_in_date: Date.today + 2,
      check_out_date: Date.today + 3
    )).to_not be_valid

    # Before trip is valid
    expect(Trip.new(
      guest: guest,
      listing: listing,
      check_in_date: Date.today - 1,
      check_out_date: Date.today
    )).to be_valid

    # Aftet trip is valid
    expect(Trip.new(
      guest: guest,
      listing: listing,
      check_in_date: Date.today + 3,
      check_out_date: Date.today + 4
    )).to be_valid
  end

  it "should find earliest available date with no trips" do
    next_available_date = Trip.earliest_available_date_for_listing(listing, 30, Date.today)
    expect(next_available_date).to eq(Date.today)
  end

  it "should find earliest available date with overlapping start trips" do
    Trip.create!(
      guest: guest,
      listing: listing,
      check_in_date: Date.today - 1,
      check_out_date: Date.today + 3
    )

    available_date_ranges = Trip.available_date_ranges_for_listing(listing, 30, Date.today)
    expect(available_date_ranges.count).to eq(1)

    next_available_date = Trip.earliest_available_date_for_listing(listing, 30, Date.today)
    expect(next_available_date).to eq(Date.today + 3)
  end

  it "should find earliest available date with some start-today trip" do
    Trip.create!(
      guest: guest,
      listing: listing,
      check_in_date: Date.today,
      check_out_date: Date.today + 3
    )

    available_date_ranges = Trip.available_date_ranges_for_listing(listing, 30, Date.today)
    expect(available_date_ranges.count).to eq(1)

    next_available_date = Trip.earliest_available_date_for_listing(listing, 30, Date.today)
    expect(next_available_date).to eq(Date.today + 3)
  end

  it "should find earliest available date with some many trip" do
    Trip.create!(
      guest: guest,
      listing: listing,
      check_in_date: Date.today,
      check_out_date: Date.today + 3
    )

    Trip.create!(
      guest: guest,
      listing: listing,
      check_in_date: Date.today + 4,
      check_out_date: Date.today + 6
    )

    expect(
      Trip.available_date_ranges_for_listing(listing, 30, Date.today).count
    ).to eq(2)

    expect(
      Trip.earliest_available_date_for_listing(listing, 30, Date.today)
    ).to eq(Date.today + 3)

    expect(
      Trip.earliest_available_date_for_listing(listing, 30, Date.today + 1)
    ).to eq(Date.today + 3)

    expect(
      Trip.earliest_available_date_for_listing(listing, 30, Date.today + 2)
    ).to eq(Date.today + 3)

    expect(
      Trip.earliest_available_date_for_listing(listing, 30, Date.today + 3)
    ).to eq(Date.today + 3)

    expect(
      Trip.earliest_available_date_for_listing(listing, 30, Date.today + 4)
    ).to eq(Date.today + 6)

    expect(
      Trip.earliest_available_date_for_listing(listing, 30, Date.today + 5)
    ).to eq(Date.today + 6)

    expect(
      Trip.earliest_available_date_for_listing(listing, 30, Date.today + 6)
    ).to eq(Date.today + 6)

    expect(
      Trip.earliest_available_date_for_listing(listing, 30, Date.today + 7)
    ).to eq(Date.today + 7)
  end
end
