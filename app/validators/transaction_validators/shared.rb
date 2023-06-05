# frozen_string_literal: true

module TransactionValidators
  module Shared
    def to_currency_from_list_validation(record)
      return if Transaction::AVAILABLE_CURRENCIES.include?(record.to_currency)

      record.errors.add(:to_currency, 'the currency is not available')
    end

    def from_currency_from_list_validation(record)
      return if Transaction::AVAILABLE_CURRENCIES.include?(record.from_currency)

      record.errors.add(:from_currency, 'the currency is not available')
    end

    def currencies_differ_validation(record)
      return if record.from_currency != record.to_currency

      record.errors.add(:from_currency, "can't be converted to the same currency.")
    end

    def from_currency_specify_validation(record)
      return if record.from_currency == 'USD'

      record.errors.add(:from_currency, 'available only for conversions over $1000.')
    end

    def first_name_present_validation(record)
      return if record.first_name.present?

      record.errors.add(:first_name, 'is blank.')
    end

    def last_name_present_validation(record)
      return if record.last_name.present?

      record.errors.add(:last_name, 'is blank.')
    end

    def manager_present_validation(record)
      return if record.manager.is_a?(Manager)

      record.errors.add(:manager, 'conversions over $1000 require a personal manager.')
    end

    def uid_is_present_validation(record)
      return if record.uid.present?

      record.errors.add(:uid, 'is blank.')
    end

    def uid_is_unique_validation(record)
      return unless Transaction.where.not(id: record).exists?(uid: record.uid)

      record.errors.add(:uid, 'is not unique.')
    end
  end
end
