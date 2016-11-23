require 'rails_helper'

RSpec.describe "reviews/edit", type: :view do
  before(:each) do
    @review = assign(:review, Review.create!(
      :trip => nil,
      :content => "MyText",
      :rating => "9.99"
    ))
  end

  it "renders the edit review form" do
    render

    assert_select "form[action=?][method=?]", review_path(@review), "post" do

      assert_select "input#review_trip_id[name=?]", "review[trip_id]"

      assert_select "textarea#review_content[name=?]", "review[content]"

      assert_select "input#review_rating[name=?]", "review[rating]"
    end
  end
end
