require 'rails_helper'

RSpec.describe "listings/index", type: :view do
  before(:each) do
    host_user = User.create!(
      email: 'host@example.com',
      password: 'ABCDEF123456',
      password_confirmation: 'ABCDEF123456'
    )
    @region1 = Region.create!(name: 'Melbourne', country_code: 'au')
    @region2 = Region.create!(name: 'Melbourne', country_code: 'us')

    @listing1, @listing2 = assign(:listings, [
      Listing.create!(
        :host => host_user,
        :region => @region1,
        :address => @region1.address
      ),
      Listing.create!(
        :host => host_user,
        :region => @region2,
        :address => @region2.address
      )
    ])
  end

  it "renders a list of listings" do
    render
    assert_select "tr>td", :text => "host@example.com", :count => 2
    assert_select "tr>td", :text => "Melbourne, Australia", :count => 1
    assert_select "tr>td", :text => "Melbourne, United States", :count => 1
    assert_select "tr>td", :text => @listing1.lat.to_s, :count => 1
    assert_select "tr>td", :text => @listing2.lng.to_s, :count => 1
  end
end
