namespace :update_currency do
  desc "Update the currency for expenses and debts"
  task run: :environment do
    Trip.find_each do |trip|
      puts "Trip##{trip.id} - Updating debts..."
      trip.expenses.includes(:debts).find_each do |expense|
        expense.debts.update_all(amount_currency: trip.currency)
      end
      puts "Trip##{trip.id} - Updating expenses..."
      trip.expenses.update_all(amount_currency: trip.currency)
    end
  end
end
