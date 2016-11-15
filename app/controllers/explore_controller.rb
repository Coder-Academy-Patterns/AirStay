class ExploreController < ApplicationController
  def index
    @regions = Region.all.limit(10)
    Region.load_weathers_for(@regions)
  end
end
