module CurrenciesHelper

  def currencies_available
    ::CurrencyDecorator.decorate_collection(::Money::Currency.all)
  end
end
