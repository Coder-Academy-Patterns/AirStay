require 'rails_helper'

RSpec.describe "stays/index", type: :view do
  before(:each) do
    assign(:stays, [
      Stay.create!(
        :guest => nil,
        :listing => nil,
        :stripe_charge_id => "Stripe Charge"
      ),
      Stay.create!(
        :guest => nil,
        :listing => nil,
        :stripe_charge_id => "Stripe Charge"
      )
    ])
  end

  it "renders a list of stays" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Stripe Charge".to_s, :count => 2
  end
end
