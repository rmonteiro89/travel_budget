class ExpensesController < ApplicationController

  def create
    trip = find_trip
    new_expense = trip.expenses.build(expense_params)
    new_expense.save

    redirect_to trip
  end

  def update
    trip = find_trip
    expense = trip.expenses.find(params[:id])
    expense.update_attributes(expense_params)

    redirect_to trip
  end

  def destroy
    trip = find_trip
    expense = trip.expenses.find(params[:id])
    expense.destroy

    flash[:notice] = "Expense deleted!"
    redirect_to trip
  end

  private
  def find_trip
    current_user.trips.find(params[:trip_id])
  end

  def expense_params
    params.require(:expense).permit(:date, :category_id, :amount, :description)
  end
end
