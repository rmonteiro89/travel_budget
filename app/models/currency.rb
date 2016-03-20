class Currency < ActiveRecord::Base
  has_many :users
  has_one :country
end
