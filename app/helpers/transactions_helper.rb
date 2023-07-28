# frozen_string_literal: true

module TransactionsHelper
  def small_amount_title
    "Create 0-#{Transaction::LARGE_AMOUNT} USD Transaction"
  end

  def large_amount_title
    "Create #{Transaction::LARGE_AMOUNT}-#{Transaction::EXTRA_AMOUNT} USD Transaction"
  end

  def extra_amount_title
    "Create >#{Transaction::EXTRA_AMOUNT} USD Transaction"
  end

  def transaction_amount(amount, currency)
    number_to_currency(
      amount,
      unit: currency,
      separator: ",",
      delimiter: " ",
      format: "%n %u"
    )
  end

  def shorten_uid(uid)
    uid.length > 12 ? "#{uid[0, 6]}...#{uid[-4, 4]}" : uid
  end
end
