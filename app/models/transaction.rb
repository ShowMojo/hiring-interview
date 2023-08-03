class Transaction < ApplicationRecord
  AVAILABLE_CURRENCIES = ['USD', 'GBP', 'AUD', 'CAD'].freeze
  MAXIMUM_FOR_SMALL_TRANSACTION = 99
  MAXIMUM_FOR_LARGE_TRANSACTION = 1000

  belongs_to :manager, optional: true

  monetize :from_amount_cents, with_currency: ->(t) { t.from_currency }, numericality: { greater_than: 0 }
  monetize :to_amount_cents, with_currency: ->(t) { t.to_currency }, numericality: { greater_than: 0 }

  validates :from_currency, inclusion: AVAILABLE_CURRENCIES
  validates :to_currency, inclusion: AVAILABLE_CURRENCIES
  validate :currencies_validation

  before_create :generate_uid
  before_validation :convert_currency

  def self.transaction_type_classes
    SubclassFinder.find_subclasses_for(Transaction, namespace: Transactions)
  end

  def self.subclass_for(type)
    subclass = transaction_type_classes.select do |transaction_type_class| 
      transaction_type_class.for?(type)
    end.first
    raise ArgumentError, "No Upload Type found #{type}" if subclass.nil?

    subclass
  end

  def self.for?(_type)
    false
  end

  def client_full_name
    "#{first_name} #{last_name}"
  end

  private

  def generate_uid
    self.uid = SecureRandom.hex(5)
  end

  def convert_currency
    self.to_amount = from_amount.exchange_to(self.to_currency)
  end

  def from_amount_in_usd
    from_amount.exchange_to('USD')
  end

  def currencies_validation
    if from_currency == to_currency
      errors.add(:from_currency, "can't be converted to the same currency.")
    end
  end
end

# eager load all transaction type subclasses as they are needed by Transaction class
Dir[Rails.root.join('app/models/transactions/*.rb')].each do |file|
  require_dependency(file)
end
