class Expense < ActiveRecord::Base
  belongs_to :trip
  belongs_to :category
  belongs_to :users

  monetize :amount_cents

  delegate :name, to: :category, allow_nil: true, prefix: true
end
