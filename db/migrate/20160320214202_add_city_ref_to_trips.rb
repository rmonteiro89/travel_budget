class AddCityRefToTrips < ActiveRecord::Migration
  def change
    add_reference :trips, :city, index: true, foreign_key: true
  end
end
