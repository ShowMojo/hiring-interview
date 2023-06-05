# frozen_string_literal: true

module TransactionValidators
  class Base < ActiveModel::Validator
    include Shared

    def validate(record)
      from_currency_from_list_validation(record)
      to_currency_from_list_validation(record)
      currencies_differ_validation(record)
      uid_is_present_validation(record)
      uid_is_unique_validation(record)
    end
  end
end
