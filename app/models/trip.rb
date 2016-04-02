class Trip < ActiveRecord::Base
  has_and_belongs_to_many :users, autosave: true
  has_many :expenses

  monetize :exchange_rate_cents

  def total
    expenses.inject(Money.new(0)) { |sum, expense| sum + expense.amount }
  end
end
