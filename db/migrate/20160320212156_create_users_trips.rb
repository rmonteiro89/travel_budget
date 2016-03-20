class CreateUsersTrips < ActiveRecord::Migration
  def change
    create_table :users_trips do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :trip, index: true, foreign_key: true
    end
  end
end
