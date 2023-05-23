module Exchangable
  extend ActiveSupport::Concern

  included do
    AVAILABLE_CURRENCIES = ['USD', 'GBP', 'AUD', 'CAD'].freeze

    validates :from_currency, inclusion: AVAILABLE_CURRENCIES
    validates :to_currency, inclusion: AVAILABLE_CURRENCIES
    validate :currencies_validation
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

    def convert
      if self.to_amount.blank?
        self.to_amount = from_amount.exchange_to(self.to_currency)
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
  end

end
