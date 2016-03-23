class Country < ActiveRecord::Base
  has_many :cities
  belongs_to :currency

  accepts_nested_attributes_for :currency
end
