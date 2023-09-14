class Transaction < ApplicationRecord
  self.implicit_order_column = 'created_at'

  AVAILABLE_CURRENCIES = %w[USD GBP AUD CAD].freeze

  belongs_to :manager, optional: true

  monetize :from_amount_cents, with_currency: ->(t) { t.from_currency }, numericality: { greater_than: 0 }
  monetize :to_amount_cents, with_currency: ->(t) { t.to_currency }

  validates :first_name, presence: true, if: :large?
  validates :last_name, presence: true, if: :large?
  validates :from_currency, inclusion: AVAILABLE_CURRENCIES
  validates :to_currency, inclusion: AVAILABLE_CURRENCIES
  validate :currencies_validation
  validate :manager_validation

  before_validation :convert

  def large?
    from_amount_in_usd > Money.from_amount(100)
  end

  def extra_large?
    from_amount_in_usd > Money.from_amount(1000)
  end

  def from_amount_in_usd
    from_amount.exchange_to('USD')
  end

  private

  def convert
    return unless to_amount.blank?

    self.to_amount = from_amount.exchange_to(to_currency)
  end

  def currencies_validation
    errors.add(:from_currency, "can't be converted to the same currency.") if from_currency == to_currency
    return unless !extra_large? && from_currency != 'USD'

    errors.add(:from_currency, 'available only for conversions over $1000.')
  end

  def manager_validation
    return unless extra_large? && !manager

    errors.add(:base, 'conversions over $1000 require personal manager.')
  end
end
