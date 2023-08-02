class Transaction::Large < Transaction
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :from_currency, inclusion: { in: ['USD'] }
  validate :validate_amount

  private

  def validate_amount
    errors.add(:from_amount, "is to big for this type of transaction") if from_amount_in_usd >= Money.from_amount(EXTRA_LARGE_AMOUNT)
    errors.add(:from_amount, "is to small for this type of transaction") if from_amount_in_usd < Money.from_amount(LARGE_AMOUNT)
  end
end
