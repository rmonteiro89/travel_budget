class ExpensesController < ApplicationController

  def create
    trip = Trip.find(params[:trip_id])
    new_expense = trip.expenses.build(expense_params)
    new_expense.save

    redirect_to trip
  end

  def update
    trip = Trip.find(params[:trip_id])
    expense = trip.expenses.find(params[:id])
    expense.update_attributes(expense_params)

    redirect_to trip
  end

  def destroy
    trip = Trip.find(params[:trip_id])
    expense = trip.expenses.find(params[:id])
    expense.destroy

    flash[:notice] = "Expense deleted!"
    redirect_to trip
  end

  private
  def expense_params
    params.require(:expense).permit(:date, :category_id, :amount, :description)
  end
end
