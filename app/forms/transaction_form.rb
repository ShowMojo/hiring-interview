class TransactionForm
  include ActiveModel::Model

  attr_accessor :transaction
  delegate :first_name, :last_name, :from_currency, :to_currency, :from_amount, :manager, to: :transaction

  validates :from_currency, :to_currency, inclusion: Transaction::AVAILABLE_CURRENCIES
  validates :to_currency, exclusion: { in: ->(f) { [f.from_currency] }, message: "can't be converted to the same currency." }

  def initialize(params= {})
    @transaction = Transaction.new(params)
  end

  def save
    valid? && transaction.save!
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Transaction")
  end
end
