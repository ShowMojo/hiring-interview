class LargeTransactionForm < TransactionForm
  AVAILABLE_FROM_CURRENCIES = ['USD'].freeze

  validates :from_currency, inclusion: AVAILABLE_FROM_CURRENCIES
  validates :first_name, :last_name, presence: true
  validates :from_amount, numericality: { greater_than: 100, less_than_or_equal_to: 1000 }
end
