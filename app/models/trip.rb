class Trip < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_one :city

  monetize :exchange_rate
end
