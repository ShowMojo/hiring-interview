# frozen_string_literal: true

module TransactionValidators
  class Large < Base
    def validate(record)
      super

      from_currency_specify_validation(record)
      first_name_present_validation(record)
      last_name_present_validation(record)
    end
  end
end
