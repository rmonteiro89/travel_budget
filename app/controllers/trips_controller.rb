class TripsController < ApplicationController
  before_action :authenticate_user!

  def index
    @trips = current_user.trips
  end

  def create
    trip = current_user.trips.build(trip_params)
    ActiveRecord::Base.transaction do
      current_user.save!
    end

    flash[:notice] = "New trip created successfuly!"
    redirect_to trips_path
  rescue Exception => e
    flash[:alert] = "Cannot create the trip. Error: #{e.message}!"
    redirect_to trips_path
  end

  def update
    trip = find_trip

    ActiveRecord::Base.transaction do
      trip.update_attributes!(trip_params)
    end

    flash[:notice] = "Trip updated successfuly!"
    redirect_to trip
  rescue Exception => e
    flash[:alert] = "Cannot update the trip. Error: #{e.message}!"
    redirect_to trip
  end

  def show
    @trip = find_trip
  end

  def destroy
    trip = find_trip
    trip.destroy

    flash[:notice] = "Trip deleted!"
    redirect_to trips_path
  end

  private
  def find_trip
    current_user.trips.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :country, :city, :currency)
  end
end
