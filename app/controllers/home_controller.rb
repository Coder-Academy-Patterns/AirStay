class HomeController < ApplicationController
  def index
    if user_signed_in?
      user = current_user
      # If user has just signed up, make them fill out their profile
      redirect_to new_profile_url if user.profile.nil?

      @profile = user.profile
    end
  end
end
