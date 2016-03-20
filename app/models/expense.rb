class Expense < ActiveRecord::Base
  has_one :trip
  has_one :category

  monetize :value
end
