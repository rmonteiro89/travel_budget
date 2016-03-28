class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :default_currency, class_name: 'Currency'
  has_many :categories
  has_and_belongs_to_many :trips, autosave: true

  after_create :add_default_categories

  private
  def add_default_categories
    categories << Category.default
  end
end
