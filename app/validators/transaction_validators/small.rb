# frozen_string_literal: true

module TransactionValidators
  class Small < Base
    def validate(record)
      super

      from_currency_specify_validation(record)
    end
  end
end
