class Expense < ActiveRecord::Base
  belongs_to :trip
  belongs_to :category
  belongs_to :user

  monetize :amount_cents

  scope :by_user, -> (user) { where(user_id: user.id) }
  delegate :name, to: :category, allow_nil: true, prefix: true
end
