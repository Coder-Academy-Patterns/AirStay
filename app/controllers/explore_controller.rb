class ExploreController < ApplicationController
  def index
    @regions = Region.all.limit(10)
    @weathers = Region.weathers_for(@regions)
  end
end
