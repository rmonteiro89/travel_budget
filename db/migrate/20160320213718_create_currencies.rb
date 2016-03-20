class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :symbol
      t.string :decimal_mark, default: ","
      t.timestamps null: false
    end
  end
end
