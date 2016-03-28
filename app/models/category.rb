class Category < ActiveRecord::Base
  has_many :expenses
  belongs_to :user

  def self.default
    [new(name: 'Accomodation'), new(name: 'Food'), new(name: 'Transport'), new(name: 'Activities')]
  end
end
