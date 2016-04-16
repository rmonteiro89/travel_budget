class Trip < ActiveRecord::Base
  has_and_belongs_to_many :users, autosave: true
  has_many :expenses

  monetize :exchange_rate_cents, with_model_currency: :currency

  def local_currency
    ::Money::Currency.find(currency)
  end

  def current_week_by_user(user)
    expenses = expenses_by_user(user).order(:date)
    return Money.new(0, currency) unless expenses

    first_day_of_week = expenses.last.date.beginning_of_week
    expenses.where('date >= ?', first_day_of_week).inject(Money.new(0, currency)) { |sum, expense| sum + expense.amount }
  end

  def average_per_day_by_user(user)
    expenses = expenses_by_user(user).order(:date)
    return Money.new(0, currency) unless expenses

    amount_of_days = (expenses.last.date - expenses.first.date).to_i
    (total_by_user(user) / amount_of_days)
  end

  def average_per_week_by_user(user)
    average_per_day_by_user(user) * 7
  end

  def expenses_by_user(user)
    expenses.by_user(user)
  end

  def total_by_user(user)
    sum_expenses_by_user_with(user, :amount)
  end

  def paid_for_total_by_user(user)
    sum_expenses_by_user_with(user, :total_debt)
  end

  def total_by_user_in_exchange_currency(user)
    calc_in_exchange_currency(total_by_user(user).cents)
  end

  def paid_for_total_by_user_in_exchange_currency(user)
    calc_in_exchange_currency(paid_for_total_by_user(user).cents)
  end

  def calc_in_exchange_currency(value_in_cents)
    return Money.new(0) if self.exchange_rate_cents.zero?

    total_exchange = value_in_cents * self.exchange_rate_cents / self.local_currency.smallest_denomination**2
    Money.new(total_exchange, self.exchange_rate_currency)
  end

  private
  def sum_expenses_by_user_with(user, method)
    expenses_by_user(user).inject(Money.new(0, currency)) { |sum, expense| sum + expense.send(method) }
  end
end
