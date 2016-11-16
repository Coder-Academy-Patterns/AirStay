class ExploreController < ApplicationController
  def index
    @where = params.dig(:search, :where)
    
    search_regions(@where)

    respond_to do |format|
      format.html
      format.js { render :search }
    end
  end

  private
    def search_regions(where = nil)
      if where.present?
        @regions = Region.name_starts_with(where).or(Region.country_search(where))
      else
        @regions = Region.all.limit(10)
      end
      Region.load_weathers_for(@regions)
    end
end
