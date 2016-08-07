class HomeController < ApplicationController
  def index
    if current_user.present?
      redirect_to trips_path
    else
      @user = User.new
    end
  end
end
