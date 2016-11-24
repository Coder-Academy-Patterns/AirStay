require "rails_helper"

RSpec.describe ListingProvisionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/listing_provisions").to route_to("listing_provisions#index")
    end

    it "routes to #new" do
      expect(:get => "/listing_provisions/new").to route_to("listing_provisions#new")
    end

    it "routes to #show" do
      expect(:get => "/listing_provisions/1").to route_to("listing_provisions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/listing_provisions/1/edit").to route_to("listing_provisions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/listing_provisions").to route_to("listing_provisions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/listing_provisions/1").to route_to("listing_provisions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/listing_provisions/1").to route_to("listing_provisions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/listing_provisions/1").to route_to("listing_provisions#destroy", :id => "1")
    end

  end
end
