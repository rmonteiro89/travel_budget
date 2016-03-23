class City < ActiveRecord::Base
  has_many :trips
  belongs_to :country

  accepts_nested_attributes_for :country

  delegate :name, to: :country, prefix: true
end
