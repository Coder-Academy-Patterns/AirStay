require 'rails_helper'

RSpec.describe "listings/edit", type: :view do
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

  it "renders the edit listing form" do
    render

    assert_select "form[action=?][method=?]", listing_path(@listing), "post" do

      assert_select "input#listing_host_id[name=?]", "listing[host_id]"

      assert_select "input#listing_region_id[name=?]", "listing[region_id]"

      assert_select "input#listing_address[name=?]", "listing[address]"

    end
  end
end
