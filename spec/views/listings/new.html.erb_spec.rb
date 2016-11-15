require 'rails_helper'

RSpec.describe "listings/new", type: :view do
  before(:each) do
    assign(:listing, Listing.new(
      :host => nil,
      :region => nil,
      :address => "MyString",
      :lat => "9.99",
      :lng => "9.99"
    ))
  end

  it "renders new listing form" do
    render

    assert_select "form[action=?][method=?]", listings_path, "post" do

      assert_select "input#listing_host_id[name=?]", "listing[host_id]"

      assert_select "input#listing_region_id[name=?]", "listing[region_id]"

      assert_select "input#listing_address[name=?]", "listing[address]"

      assert_select "input#listing_lat[name=?]", "listing[lat]"

      assert_select "input#listing_lng[name=?]", "listing[lng]"
    end
  end
end
