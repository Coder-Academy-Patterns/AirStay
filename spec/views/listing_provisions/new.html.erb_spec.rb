require 'rails_helper'

RSpec.describe "listing_provisions/new", type: :view do
  before(:each) do
    assign(:listing_provision, ListingProvision.new(
      :listing => nil,
      :guest_max_count => 1,
      :bed_count => 1,
      :minimum_nights => 1,
      :nightly_fee_cents => 1,
      :cleaning_fee_cents => 1
    ))
  end

  it "renders new listing_provision form" do
    render

    assert_select "form[action=?][method=?]", listing_provisions_path, "post" do

      assert_select "input#listing_provision_listing_id[name=?]", "listing_provision[listing_id]"

      assert_select "input#listing_provision_guest_max_count[name=?]", "listing_provision[guest_max_count]"

      assert_select "input#listing_provision_bed_count[name=?]", "listing_provision[bed_count]"

      assert_select "input#listing_provision_minimum_nights[name=?]", "listing_provision[minimum_nights]"

      assert_select "input#listing_provision_nightly_fee_cents[name=?]", "listing_provision[nightly_fee_cents]"

      assert_select "input#listing_provision_cleaning_fee_cents[name=?]", "listing_provision[cleaning_fee_cents]"
    end
  end
end
