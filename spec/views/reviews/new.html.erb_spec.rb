require 'rails_helper'

RSpec.describe "reviews/new", type: :view do
  before(:each) do
    assign(:review, Review.new(
      :trip => nil,
      :content => "MyText",
      :rating => "9.99"
    ))
  end

  it "renders new review form" do
    render

    assert_select "form[action=?][method=?]", reviews_path, "post" do

      assert_select "input#review_trip_id[name=?]", "review[trip_id]"

      assert_select "textarea#review_content[name=?]", "review[content]"

      assert_select "input#review_rating[name=?]", "review[rating]"
    end
  end
end
