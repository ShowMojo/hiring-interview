class Transaction < ApplicationRecord
  # prevent single-table inheritance mechanism failing
  self.inheritance_column = 'ptype'

  self.implicit_order_column = 'created_at'

  AVAILABLE_CURRENCIES = %w[USD GBP AUD CAD].freeze
  SMALL_LIMIT = 100
  LARGE_LIMIT = 1000

  enum type: { small: 0, large: 1, extra_large: 3 }

  belongs_to :manager, optional: true

  monetize :from_amount_cents, with_currency: ->(t) { t.from_currency }, numericality: { greater_than: 0 }
  monetize :to_amount_cents, with_currency: ->(t) { t.to_currency }

  validates :first_name, presence: true, if: :large?
  validates :last_name, presence: true, if: :large?
  validates :from_currency, inclusion: AVAILABLE_CURRENCIES
  validates :to_currency, inclusion: AVAILABLE_CURRENCIES
  validate :currencies_validation
  validate :manager_validation
  validate :amount_validation

  before_validation :convert

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

  def amount_validation
    if small? && from_amount_in_usd > Money.from_amount(SMALL_LIMIT)
      errors.add(:from_amount, "this type for #{type} conversions is limited by #{SMALL_LIMIT}")
    elsif large? && from_amount_in_usd > Money.from_amount(LARGE_LIMIT)
      errors.add(:from_amount, "this type of conversion is limited by #{LARGE_LIMIT}")
    end
  end
end
