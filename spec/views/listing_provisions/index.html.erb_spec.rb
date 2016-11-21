require 'rails_helper'

RSpec.describe "listing_provisions/index", type: :view do
  before(:each) do
    assign(:listing_provisions, [
      ListingProvision.create!(
        :listing => nil,
        :guest_max_count => 2,
        :bed_count => 3,
        :minimum_nights => 4,
        :nightly_fee_cents => 5,
        :cleaning_fee_cents => 6
      ),
      ListingProvision.create!(
        :listing => nil,
        :guest_max_count => 2,
        :bed_count => 3,
        :minimum_nights => 4,
        :nightly_fee_cents => 5,
        :cleaning_fee_cents => 6
      )
    ])
  end

  it "renders a list of listing_provisions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
