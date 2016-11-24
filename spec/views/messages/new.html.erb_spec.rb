require 'rails_helper'

RSpec.describe "messages/new", type: :view do
  before(:each) do
    assign(:message, Message.new(
      :guest => nil,
      :listing => nil,
      :content => "MyText"
    ))
  end

  it "renders new message form" do
    render

    assert_select "form[action=?][method=?]", messages_path, "post" do

      assert_select "input#message_guest_id[name=?]", "message[guest_id]"

      assert_select "input#message_listing_id[name=?]", "message[listing_id]"

      assert_select "textarea#message_content[name=?]", "message[content]"
    end
  end
end
