require 'rails_helper'

RSpec.describe "stays/new", type: :view do
  before(:each) do
    assign(:stay, Stay.new(
      :guest => nil,
      :listing => nil,
      :stripe_charge_id => "MyString"
    ))
  end

  it "renders new stay form" do
    render

    assert_select "form[action=?][method=?]", stays_path, "post" do

      assert_select "input#stay_guest_id[name=?]", "stay[guest_id]"

      assert_select "input#stay_listing_id[name=?]", "stay[listing_id]"

      assert_select "input#stay_stripe_charge_id[name=?]", "stay[stripe_charge_id]"
    end
  end
end
