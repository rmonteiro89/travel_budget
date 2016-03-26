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
    redirect_to trips_url
  rescue Exception => e
    flash[:alert] = "Cannot create the trip. Error: #{e.message}!"
    redirect_to trips_url
  end

  def show
    @trip = Trip.find(params[:id])
  end

  private
  def trip_params
    params.require(:trip).permit(:start_date, :end_date,
      city_attributes: [:name,
        country_attributes: [:name,
          currency_attributes: [:name, :symbol]],
      ])
  end
end
