require 'rails_helper'

RSpec.describe "Stays", type: :request do
  describe "GET /stays" do
    it "works! (now write some real specs)" do
      get stays_path
      expect(response).to have_http_status(200)
    end
  end
end
