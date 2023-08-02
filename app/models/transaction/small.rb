class Transaction::Small < Transaction
  validates :from_currency, inclusion: { in: ['USD'] }
  validate :validate_amount

  private

  def validate_amount
    if from_amount_in_usd >= Money.from_amount(LARGE_AMOUNT)
      errors.add(:from_amount, "is to big for this type of transaction")
    end
  end
end
