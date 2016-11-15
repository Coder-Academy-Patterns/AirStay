require 'rails_helper'

RSpec.describe "listings/index", type: :view do
  before(:each) do
    assign(:listings, [
      Listing.create!(
        :host => nil,
        :region => nil,
        :address => "Address",
        :lat => "9.99",
        :lng => "9.99"
      ),
      Listing.create!(
        :host => nil,
        :region => nil,
        :address => "Address",
        :lat => "9.99",
        :lng => "9.99"
      )
    ])
  end

  it "renders a list of listings" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
