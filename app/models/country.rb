class Country < ActiveRecord::Base
  has_many :cities
  belongs_to :currency
end
