class InvitesController < ApplicationController

  def create
    trip = current_user.trips.find(params[:trip_id])
    invited_user = User.find_by(email: invite_params[:email])

    if invited_user
      trip.users << invited_user
      flash[:notice] = "#{invited_user.email} was added to this trip!"
    else
      flash[:alert] = "User #{invite_params[:email]} is not registered!"
    end

    redirect_to trip
  end

  private
  def invite_params
    params.require(:invite).permit(:email)
  end
end
