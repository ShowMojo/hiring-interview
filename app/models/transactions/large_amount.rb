module Transactions
  class LargeAmount < Transaction
    TRANSACTION_TYPE = 'large'

    validate :validate_from_amount
    validates :first_name, presence: true
    validates :last_name, presence: true

    def self.for?(type)
      type == TRANSACTION_TYPE
    end
  
    private

    def validate_from_amount
      if from_amount_in_usd <= Money.from_amount(MAXIMUM_FOR_SMALL_TRANSACTION)
        errors.add(:from_amount, "is too small for large transaction")
      elsif from_amount_in_usd > Money.from_amount(MAXIMUM_FOR_LARGE_TRANSACTION)
        errors.add(:from_amount, "is too big for large transaction")
      end
    end
  end
end
