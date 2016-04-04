class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.monetize :amount
      t.integer :recipient_id, index: true
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :expense, index: true, foreign_key: true
      t.boolean :paid, default: false
      t.timestamps null: false
    end
  end
end
