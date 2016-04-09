class Trip < ActiveRecord::Base
  has_and_belongs_to_many :users, autosave: true
  has_many :expenses

  monetize :exchange_rate_cents, with_model_currency: :currency

  def local_currency
    ::Money::Currency.find(currency)
  end

  def expenses_by_user(user)
    expenses.by_user(user)
  end

  def total_by_user(user)
    expenses_by_user(user).inject(Money.new(0, currency)) { |sum, expense| sum + expense.amount }
  end

  def paid_for_total_by_user(user)
    expenses_by_user(user).inject(Money.new(0, currency)) { |sum, expense| sum + expense.total_debt }
  end
end
