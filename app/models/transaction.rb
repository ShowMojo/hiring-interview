class Transaction < ApplicationRecord
  AVAILABLE_CURRENCIES = ['USD', 'GBP', 'AUD', 'CAD'].freeze

  belongs_to :manager, optional: true

  monetize :from_amount_cents, with_currency: ->(t) { t.from_currency }, numericality: { greater_than: 0 }
  monetize :to_amount_cents, with_currency: ->(t) { t.to_currency }

  before_create :generate_uid
  before_validation :convert

  def client_full_name
    "#{first_name} #{last_name}"
  end

  private

  def generate_uid
    self.uid = SecureRandom.hex(5)
  end

  def convert
    if self.to_amount.blank?
      self.to_amount = from_amount.exchange_to(self.to_currency)
    end
  end
end
