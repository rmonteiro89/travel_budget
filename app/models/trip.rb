class Trip < ActiveRecord::Base
  has_and_belongs_to_many :users, autosave: true
  has_many :expenses

  monetize :exchange_rate_cents

  def expenses_by_user(user)
    expenses.by_user(user)
  end

  def total_by_user(user)
    expenses_by_user(user).inject(Money.new(0)) { |sum, expense| sum + expense.amount }
  end

  def paid_for_total_by_user(user)
    expenses_by_user(user).inject(Money.new(0)) { |sum, expense| sum + expense.total_debt }
  end
end
