# frozen_string_literal: true

module TransactionValidators
  class Extra < Base
    def validate(record)
      super

      manager_present_validation(record)
      first_name_present_validation(record)
      last_name_present_validation(record)
    end
  end
end
