require 'rails_helper'

RSpec.describe "messages/edit", type: :view do
  before(:each) do
    @message = assign(:message, Message.create!(
      :guest => nil,
      :listing => nil,
      :content => "MyText"
    ))
  end

  it "renders the edit message form" do
    render

    assert_select "form[action=?][method=?]", message_path(@message), "post" do

      assert_select "input#message_guest_id[name=?]", "message[guest_id]"

      assert_select "input#message_listing_id[name=?]", "message[listing_id]"

      assert_select "textarea#message_content[name=?]", "message[content]"
    end
  end
end
