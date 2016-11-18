require 'rails_helper'

RSpec.describe "stays/show", type: :view do
  before(:each) do
    @stay = assign(:stay, Stay.create!(
      :guest => nil,
      :listing => nil,
      :stripe_charge_id => "Stripe Charge"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Stripe Charge/)
  end
end
