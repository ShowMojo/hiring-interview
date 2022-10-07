class SmallTransactionForm < TransactionForm
  AVAILABLE_FROM_CURRENCIES = ['USD'].freeze

  validates :from_amount, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  validates :from_currency, inclusion: AVAILABLE_FROM_CURRENCIES
end
