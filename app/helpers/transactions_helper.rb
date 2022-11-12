module TransactionsHelper
  def from_amount(transaction)
    format_amount(transaction.from_amount, transaction.from_currency)
  end

  def to_amount(transaction)
    format_amount(transaction.to_amount, transaction.to_currency)
  end

  def format_amount(amount, unit)
    number_to_currency(amount,
                       unit: unit,
                       separator: ",",
                       delimiter: " ",
                       format: "%n %u")
  end
end
