class CurrentUsersController < ApplicationController
  def update
    session[:user_id] = params[:user_id]
    redirect_back fallback_location: root_path, status: :see_other
  end
end