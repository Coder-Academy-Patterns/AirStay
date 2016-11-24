require 'rails_helper'

RSpec.describe "listing_provisions/show", type: :view do
  before(:each) do
    @listing_provision = assign(:listing_provision, ListingProvision.create!(
      :listing => nil,
      :guest_max_count => 2,
      :bed_count => 3,
      :minimum_nights => 4,
      :nightly_fee_cents => 5,
      :cleaning_fee_cents => 6
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
  end
end
