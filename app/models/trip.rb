class Trip < ActiveRecord::Base
  has_and_belongs_to_many :users, autosave: true
  belongs_to :city
  has_many :expenses

  monetize :exchange_rate_cents

  accepts_nested_attributes_for :city

  delegate :name, to: :city, prefix: true
  delegate :country_name, to: :city

  def total
    expenses.inject(Money.new(0)) { |sum, expense| sum + expense.amount }
  end
end
