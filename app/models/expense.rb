class Expense < ActiveRecord::Base
  belongs_to :trip
  has_one :category

  monetize :amount
end
