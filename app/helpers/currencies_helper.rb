module CurrenciesHelper
  def currencies_available
    Currency.all
  end
end
