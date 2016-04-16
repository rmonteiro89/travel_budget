class ExpensesController < ApplicationController
  include ExpensesHelper

  def create
    trip = find_trip
    new_expense = build_expense(trip)
    if new_expense.save
      flash[:notice] = expense_created_message(new_expense)
    else
      flash[:alert] = new_expense.errors.full_messages
    end

    redirect_to trip
  end

  def update
    expense = find_expense
    expense.update_attributes(expense_params)

    redirect_to expense.trip
  end

  def destroy
    expense = find_expense
    expense.destroy

    flash[:notice] = "Expense deleted!"
    redirect_to expense.trip
  end

  private
  def find_expense
    trip = find_trip
    trip.expenses.find_by!(id: params[:id], user_id: current_user.id)
  end

  def find_trip
    current_user.trips.find(params[:trip_id])
  end

  def build_expense(trip)
    expense = trip.expenses.build(expense_params.merge(user_id: current_user.id))
    expense.amount = expense_params[:amount]
    expense
  end

  def expense_params
    params.require(:expense).permit(:date, :category_id, :amount, :description, :amount_currency)
  end
end
