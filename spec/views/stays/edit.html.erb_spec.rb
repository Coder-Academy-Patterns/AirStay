require 'rails_helper'

RSpec.describe "stays/edit", type: :view do
  before(:each) do
    @stay = assign(:stay, Stay.create!(
      :guest => nil,
      :listing => nil,
      :stripe_charge_id => "MyString"
    ))
  end

  it "renders the edit stay form" do
    render

    assert_select "form[action=?][method=?]", stay_path(@stay), "post" do

      assert_select "input#stay_guest_id[name=?]", "stay[guest_id]"

      assert_select "input#stay_listing_id[name=?]", "stay[listing_id]"

      assert_select "input#stay_stripe_charge_id[name=?]", "stay[stripe_charge_id]"
    end
  end
end
