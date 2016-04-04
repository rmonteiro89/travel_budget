class DebtsController < ApplicationController

  def create
    debt = build_debt

    if debt.save
      flash[:notice] = 'Debt created!'
    else
      flash[:alert] = 'Cannot create debt! Error: #{debt.errors.messages}'
    end

    redirect_to debt.expense.trip
  end

  private
  def build_debt
    expense = current_user.expenses.find(params[:expense_id])
    debt = Debt.new(debt_params)
    debt.expense = expense
    debt
  end

  def debt_params
    params.require(:debt).permit(:user_id, :recipient_id, :amount, :paid)
  end
end
