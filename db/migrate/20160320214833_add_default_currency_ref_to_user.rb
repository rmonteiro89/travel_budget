class AddDefaultCurrencyRefToUser < ActiveRecord::Migration
  def change
    add_reference :users, :currency, index: true, foreign_key: true
  end
end
