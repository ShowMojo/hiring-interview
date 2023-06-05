# frozen_string_literal: true

module TransactionsHelper
  def format_money(amount, currency)
    number_to_currency(
      amount,
      unit: currency,
      separator: ',',
      delimiter: ' ',
      format: '%n %u'
    )
  end
end
