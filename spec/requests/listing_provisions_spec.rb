require 'rails_helper'

RSpec.describe "ListingProvisions", type: :request do
  describe "GET /listing_provisions" do
    it "works! (now write some real specs)" do
      get listing_provisions_path
      expect(response).to have_http_status(200)
    end
  end
end
