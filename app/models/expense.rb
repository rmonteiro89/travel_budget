class Expense < ActiveRecord::Base
  belongs_to :trip
  belongs_to :category
  belongs_to :user
  has_many :debts, dependent: :destroy

  monetize :amount_cents

  scope :by_user, -> (user) { where(user_id: user.id) }
  delegate :name, to: :category, allow_nil: true, prefix: true

  def total_debt
    debts.inject(Money.new(0)) { |sum, debt| sum + debt.amount }
  end

  def total_debt_by_user(user)
    debts.by_user(user).inject(Money.new(0)) { |sum, debt| sum + debt.amount }
  end
end
