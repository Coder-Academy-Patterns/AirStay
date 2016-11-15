require 'rails_helper'

RSpec.describe "listings/show", type: :view do
  before(:each) do
    host_user = User.create!(
      email: 'host@example.com',
      password: 'ABCDEF123456',
      password_confirmation: 'ABCDEF123456'
    )
    region = Region.create!(name: 'Melbourne', country_code: 'au')

    @listing = assign(:listing, Listing.create!(
      :host => host_user,
      :region => region,
      :address => region.address
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Melbourne, Australia/)
    expect(rendered).to match(@listing.lat.to_s)
    expect(rendered).to match(@listing.lng.to_s)
  end
end
