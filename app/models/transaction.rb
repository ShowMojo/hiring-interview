# frozen_string_literal: true

class Transaction < ApplicationRecord
  AVAILABLE_CURRENCIES = %w[USD GBP AUD CAD].freeze

  belongs_to :manager, optional: true,
                       inverse_of: :transactions

  monetize :from_amount_cents, with_currency: ->(t) { t.from_currency }, numericality: { greater_than: 0 }
  monetize :to_amount_cents, with_currency: ->(t) { t.to_currency }

  validates_with TransactionValidators::Small, if: :small?
  validates_with TransactionValidators::Large, if: :large?
  validates_with TransactionValidators::Extra, if: :extra_large?

  before_validation :generate_uid
  before_validation :convert
  before_validation :assign_manager

  def small?
    !large? && !extra_large?
  end

  def large?
    from_amount_in_usd > Money.from_amount(100) && !extra_large?
  end

  def extra_large?
    from_amount_in_usd > Money.from_amount(1000)
  end

  def from_amount_in_usd
    from_amount.exchange_to('USD')
  end

  private

  def generate_uid
    return if uid.present?

    new_uid = generate_random_uid
    new_uid = generate_random_uid while Transaction.exists?(uid: new_uid)
    self.uid = new_uid
  end

  def generate_random_uid
    SecureRandom.hex(5)
  end

  def convert
    return if to_amount.present?

    update_rates
    self.to_amount = from_amount.exchange_to(to_currency)
  end

  def assign_manager
    return if manager.present?

    self.manager = Manager.order('RANDOM()').first if extra_large?
  end

  def update_rates
    eu_bank = Money.default_bank
    return if eu_bank.rates_updated_at && eu_bank.rates_updated_at < 1.day.ago

    cache = 'exchange_rates.xml'
    eu_bank.save_rates(cache)
    eu_bank.update_rates(cache)
  end
end
