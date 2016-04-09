class Debt < ActiveRecord::Base
  belongs_to :user
  has_one :recipient, class_name: 'User', foreign_key: :id
  belongs_to :expense

  monetize :amount_cents, with_model_currency: :currency

  delegate :currency, to: :expense

  scope :by_recipient, -> (user_recipient) { where(recipient_id: user_recipient.id) }
  scope :by_user, -> (specific_user) { where(user_id: specific_user.id) }
end
