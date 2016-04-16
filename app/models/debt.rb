class Debt < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  belongs_to :expense

  validates :user, :recipient, :expense, presence: true

  monetize :amount_cents, with_model_currency: :currency

  scope :by_recipient_id, -> (user_recipient_id) { where(recipient_id: user_recipient_id) }
  scope :by_recipient, -> (user_recipient) { by_recipient_id(user_recipient.id) }
  scope :by_user_id, -> (specific_user_id) { where(user_id: specific_user_id) }
  scope :by_user, -> (specific_user) { by_user_id(specific_user.id) }
  scope :by_trip, -> (trip) { includes(:expense).where('expenses.trip_id = ?', trip.id).references(:expenses) }

  delegate :currency, to: :expense
  delegate :description, :created_at, to: :expense, prefix: true, allow_nil: true
end
