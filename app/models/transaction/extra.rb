class Transaction::Extra < Transaction
  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :manager_validation
  validate :validate_amount
  validate :currencies_validation

  private

  def manager_validation
    errors.add(:base, "conversions over $#{EXTRA_LARGE_AMOUNT} require personal manager.") unless manager
  end

  def validate_amount
    errors.add(:from_amount, "is to small for this type of transaction") if from_amount_in_usd < Money.from_amount(EXTRA_LARGE_AMOUNT)
  end

  def currencies_validation
    errors.add(:from_currency, "can't be converted to the same currency.") if from_currency == to_currency
  end
end
