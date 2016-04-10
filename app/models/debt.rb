class Debt < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  belongs_to :expense

  validates :user, :recipient, :expense, presence: true

  monetize :amount_cents, with_model_currency: :currency

  scope :by_recipient, -> (user_recipient) { where(recipient_id: user_recipient.id) }
  scope :by_user, -> (specific_user) { where(user_id: specific_user.id) }
  scope :by_trip, -> (trip) { includes(:expense).where('expenses.trip_id = ?', trip.id).references(:expenses) }

  delegate :currency, to: :expense
  delegate :description, :created_at, to: :expense, prefix: true, allow_nil: true
end
