class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    @profile = current_user.profile
    # If user has just signed up, make them fill out their profile
    if @profile.nil?
      new_profile_url
    else
      root_url
    end
  end
end
