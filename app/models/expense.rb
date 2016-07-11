class Expense < ActiveRecord::Base
  belongs_to :trip
  belongs_to :category
  belongs_to :user
  has_many :debts, dependent: :destroy

  monetize :amount_cents, with_model_currency: :currency

  scope :by_user, -> (user) { where(user_id: user.id) }

  delegate :currency, to: :trip
  delegate :name, to: :category, allow_nil: true, prefix: true

  def total_debt
    sum_debts(debts)
  end

  def total_debt_by_user(user)
    sum_debts(debts.by_user(user))
  end

  private

  def sum_debts(debts)
    debts.inject(Money.new(0, currency)) { |a, e| a + e.amount }
  end
end
