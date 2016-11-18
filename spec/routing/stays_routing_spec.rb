require "rails_helper"

RSpec.describe StaysController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/stays").to route_to("stays#index")
    end

    it "routes to #new" do
      expect(:get => "/stays/new").to route_to("stays#new")
    end

    it "routes to #show" do
      expect(:get => "/stays/1").to route_to("stays#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/stays/1/edit").to route_to("stays#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/stays").to route_to("stays#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/stays/1").to route_to("stays#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/stays/1").to route_to("stays#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/stays/1").to route_to("stays#destroy", :id => "1")
    end

  end
end
