module Transactions
  class ExtraLargeAmount < Transaction
    TRANSACTION_TYPE = 'extra'

    validate :validate_from_amount
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :manager, presence: true

    def self.for?(type)
      type == TRANSACTION_TYPE
    end
  
    private

    def validate_from_amount
      if from_amount_in_usd <= Money.from_amount(MAXIMUM_FOR_LARGE_TRANSACTION)
        errors.add(:from_amount, "available only for conversions over $1000.")
      end
    end
  end
end
