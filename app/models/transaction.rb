# frozen_string_literal: true

class Transaction < ApplicationRecord
  AVAILABLE_CURRENCIES = ['USD', 'GBP', 'AUD', 'CAD'].freeze
  ALLOWED_SIZES = ['small', 'large', 'extra'].freeze
  LARGE_AMOUNT = 100
  EXTRA_AMOUNT = 1000

  belongs_to :manager, optional: true

  monetize :from_amount_cents, with_currency: ->(t) { t.from_currency }, numericality: { greater_than: 0 }
  monetize :to_amount_cents, with_currency: ->(t) { t.to_currency }, numericality: { greater_than: 0 }

  attr_accessor :intended_size

  validates :first_name, presence: true, if: -> { intended_size != 'small' }
  validates :last_name, presence: true, if: -> { intended_size != 'small' }
  validates :from_currency, inclusion: AVAILABLE_CURRENCIES
  validates :to_currency, inclusion: AVAILABLE_CURRENCIES
  validates :uid, uniqueness: true

  validate :amount_and_size_validation
  validate :currencies_validation
  validate :manager_validation

  before_validation :convert_currency, on: :create
  before_validation :assign_manager, on: :create
  before_create :generate_uid

  def client_full_name
    "#{first_name} #{last_name}"
  end

  private

  def small?
    from_amount_in_usd <= Money.from_amount(LARGE_AMOUNT)
  end

  def large?
    from_amount_in_usd > Money.from_amount(LARGE_AMOUNT) && !extra_large?
  end

  def extra_large?
    from_amount_in_usd > Money.from_amount(EXTRA_AMOUNT)
  end

  def from_amount_in_usd
    @from_amount_in_usd ||= from_amount.exchange_to('USD')
  end

  def generate_uid
    self.uid = SecureRandom.hex(32) while (uid.blank? || Transaction.exists?(uid: uid))
  end

  def assign_manager
    self.manager = Manager.all.sample if extra_large?
  end

  def convert_currency
    self.to_amount = from_amount.exchange_to(to_currency)
  end

  def amount_and_size_validation
    if (small? && intended_size != 'small') ||
      (large? && intended_size != 'large') ||
      (extra_large? && intended_size != 'extra')
      errors.add(:from_amount, "doesn't match the transaction intention.")
    end
  end

  def currencies_validation
    if from_currency == to_currency
      errors.add(:from_currency, "can't be converted to the same currency.")
    end

    if !extra_large? && from_currency != 'USD'
      errors.add(:from_currency, "available only for conversions over $1000.")
    end
  end

  def manager_validation
    if extra_large? && !manager
      errors.add(:base, "conversions over $1000 require personal manager.")
    end
  end
end
