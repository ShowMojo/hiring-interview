module Transactions
  class SmallAmount < Transaction
    TRANSACTION_TYPE = 'small'
    validate :validate_from_amount

    def self.for?(type)
      type == TRANSACTION_TYPE
    end
  
    private

    def validate_from_amount
      if from_amount_in_usd > Money.from_amount(MAXIMUM_FOR_SMALL_TRANSACTION)
        errors.add(:from_amount, "available only for conversions less than $100.")
      end
    end
  end
end
