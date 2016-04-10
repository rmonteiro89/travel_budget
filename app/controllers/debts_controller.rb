class DebtsController < ApplicationController

  def create
    debt = build_debt

    if debt.save
      flash[:notice] = 'Debt created!'
    else
      flash[:alert] = debt.errors.full_messages
    end

    redirect_to debt.expense.trip
  end

  private
  def build_debt
    expense = current_user.expenses.find(params[:expense_id])
    debt = expense.debts.build(debt_params)
    debt.amount = debt_params[:amount]
    debt
  end

  def debt_params
    params.require(:debt).permit(:user_id, :recipient_id, :amount, :paid, :amount_currency)
  end
end
