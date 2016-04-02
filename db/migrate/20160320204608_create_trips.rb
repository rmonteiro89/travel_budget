class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.monetize :exchange_rate
      t.string :currency
      t.string :country
      t.string :city
      t.date :start_date
      t.date :end_date
      t.timestamps null: false
    end
  end
end
