class ExtraTransactionForm < TransactionForm
  FROM_CURRENCIES = Transaction::AVAILABLE_CURRENCIES

  validates :first_name, :last_name, presence: true
  validates :from_amount, numericality: { greater_than: ->(f) { f.min_amount } }

  def initialize(params= {})
    super
    @transaction.manager = Manager.order("RANDOM()").first
  end

  def min_amount
    Money.new(100000, 'USD').exchange_to(from_currency)
  end
end
