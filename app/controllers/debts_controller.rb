class DebtsController < ApplicationController
  before_action :authenticate_user!

  def index
    @trip = find_trip
    @debts = current_user.debts.by_trip(@trip)
    @credits = current_user.credits.by_trip(@trip)

    if params[:user_id]
      @user = User.find(params[:user_id])
      @debts = @debts.by_recipient(@user)
      @credits = @credits.by_user(@user)
    end
  end

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
    expense = find_expense
    debt = expense.debts.build(debt_params)
    debt.amount = debt_params[:amount]
    debt
  end

  def find_expense
    current_user.expenses.find(params[:expense_id])
  end

  def find_trip
    current_user.trips.find(params[:trip_id])
  end

  def debt_params
    params.require(:debt).permit(:user_id, :recipient_id, :amount, :paid, :amount_currency)
  end
end
