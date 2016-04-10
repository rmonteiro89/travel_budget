module DebtsHelper

  def debt_amount_by(current_user, trip, user)
    sum_debts_total_amount(current_user.debts.by_trip(trip).by_recipient(user), trip.currency)
  end

  def credit_amount_by(current_user, trip, user)
    sum_debts_total_amount(user.debts.by_trip(trip).by_recipient(current_user), trip.currency)
  end

  def sum_debts_total_amount(debts, currency)
    debts.inject(Money.new(0, currency)) { |sum, debt| sum + debt.amount }
  end
end
