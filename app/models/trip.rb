class Trip < ActiveRecord::Base
  has_and_belongs_to_many :users, autosave: true
  has_many :expenses

  scope :most_recent, -> (qt = 10) { order(start_date: :desc).limit(qt) }

  monetize :exchange_rate_cents, with_model_currency: :currency

  def amount_of_days
    (end_date - start_date + 1).to_i
  end

  def local_currency
    Currency.find(currency)
  end

  def current_day_by_user(user)
    sum_expenses(expenses_by_user(user).by_date(Date.current), :amount)
  end

  def current_week_by_user(user)
    expenses = expenses_by_user(user).order(:date)
    return Money.new(0, currency) unless expenses.present?

    week_expenses = expenses.where('date >= ?', Date.today.beginning_of_week)
    sum_expenses(week_expenses, :amount)
  end

  def average_per_day_by_user(user)
    expenses = expenses_by_user(user).order(:date)
    return Money.new(0, currency) unless expenses.present?

    current_date = Date.current > end_date ? end_date : Date.current
    amount_of_days_til_now = (current_date - start_date).to_i

    if amount_of_days_til_now > 0
      (total_by_user(user) / amount_of_days_til_now)
    else
      (total_by_user(user) / 1)
    end
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
    return Money.new(0) if exchange_rate_cents.zero?

    Money.new(total_exchange(value_in_cents), exchange_rate_currency)
  end

  def current?
    (start_date..end_date).cover?(Date.today)
  end

  private

  def total_exchange(value_in_cents)
    value_in_cents * exchange_rate_cents / (local_currency.smallest_denomination*100.00)
  end

  def sum_expenses_by_user_with(user, method)
    sum_expenses(expenses_by_user(user), method)
  end

  def sum_expenses(list, method)
    list.inject(Money.new(0, currency)) { |a, e| a + e.send(method) }
  end
end
