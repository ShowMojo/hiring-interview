class Transaction < ApplicationRecord
  AVAILABLE_CURRENCIES = ['USD', 'GBP', 'AUD', 'CAD'].freeze

  belongs_to :manager, optional: true

  monetize :from_amount_cents, with_currency: ->(t) { t.from_currency }, numericality: { greater_than: 0 }
  monetize :to_amount_cents, with_currency: ->(t) { t.to_currency }

  validates :uid, presence: true, uniqueness: true
  validates :first_name, presence: true, unless: :small?
  validates :last_name, presence: true, unless: :small?
  validates :from_currency, inclusion: AVAILABLE_CURRENCIES
  validates :from_currency,
            inclusion: { in: ['USD'], message: 'available only for conversions over $1000.', unless: :extra_large? },
            exclusion: {
              in: ->(transaction) { [transaction.to_currency] },
              message: "can't be converted to the same currency.",
            }
  validates :to_currency, inclusion: AVAILABLE_CURRENCIES
  validates :manager, presence: { message: 'conversions over $1000 require personal manager.' }, if: :extra_large?

  def small?
    from_amount_in_usd <= Money.from_amount(100)
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
end
