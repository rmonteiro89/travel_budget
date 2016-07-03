class Currency
  def self.all
    ::Money::Currency.all.map { |c| Currency.new(c) }
  end

  def self.find(code)
    money_currency = ::Money::Currency.find(code)
    new(money_currency) if money_currency
  end

  def initialize(money_currency)
    @money_currency = money_currency
  end

  def name
    @money_currency.name
  end

  def iso_code
    @money_currency.iso_code
  end

  def symbol
    @money_currency.symbol
  end

  def smallest_denomination
    @money_currency.smallest_denomination
  end

  def code_and_name
    "#{iso_code} - #{name}"
  end
end
