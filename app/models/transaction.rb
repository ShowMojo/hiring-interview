class Transaction < ApplicationRecord
  AVAILABLE_CURRENCIES = ['USD', 'GBP', 'AUD', 'CAD'].freeze

  belongs_to :manager, optional: true

  monetize :from_amount_cents, with_currency: ->(t) { t.from_currency }, numericality: { greater_than: 0 }
  monetize :to_amount_cents, with_currency: ->(t) { t.to_currency }

  validates :from_currency, inclusion: AVAILABLE_CURRENCIES
  validates :to_currency, inclusion: AVAILABLE_CURRENCIES
  validate :currencies_validation
  validate :manager_validation, :client_validation

  before_create :generate_uid
  before_validation :convert, :determine_conversion_type

  enum conversion_type: {small: 1, large: 10, extra: 20} # Just to keep space to add new types like medium or something in the future

  default_scope { order(created_at: :desc) }

  def client_full_name
    "#{first_name} #{last_name}"
  end

  def from_amount_in_usd
    from_amount.exchange_to('USD')
  end

  private

  def generate_uid
    self.uid = SecureRandom.hex(5)
  end

  # In ideal situation, would make separate model for types and it's rules for consistency.
  # In this case whenever we introduce new type, we need to update this code.(Also hardcoded numbers are not good)
  # If this rules stored in DB, we would determine type based on this data and then no need to update this code
  # when new type is introduced
  def determine_conversion_type
    self.conversion_type =  if from_amount_in_usd <= Money.from_amount(100)
                              :small
                            elsif from_amount_in_usd <= Money.from_amount(1000)
                              :large
                            else
                              :extra
                            end
  end

  def convert
    if self.to_amount.blank?
      self.to_amount = from_amount.exchange_to(self.to_currency)
    end
  end

  def currencies_validation
    if from_currency == to_currency
      errors.add(:from_currency, "can't be converted to the same currency.")
    end
    if !extra? && from_currency != 'USD'
      errors.add(:from_currency, "available only for conversions over $1000.")
    end
  end

  def manager_validation
    if extra? && !manager
      errors.add(:base, "conversions over $1000 require personal manager.")
    end

    if !extra? && manager
      errors.add(:base, "Only conversions over $1000 may be assigned personal manager.")
    end
  end

  def client_validation
    if (first_name || last_name) && small?
      errors.add(:base, "Only conversions over 100 may contain client information.")
    end

    if !(first_name && last_name) && !small?
      errors.add(:base, "conversions over 100 must contain client information.")
    end
  end
end
