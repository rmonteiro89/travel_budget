class CurrencyDecorator < Draper::Decorator
  delegate_all

  def code_and_name
    "#{object.iso_code} - #{object.name}"
  end
end
