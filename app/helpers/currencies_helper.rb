module CurrenciesHelper
  def currencies_available
    ::Money::Currency.all
  end
end
