class TransactionDecorator < Draper::Decorator
  delegate_all
  include ActionView::Helpers::NumberHelper

  def from_amount_format
    number_to_currency(object.from_amount, unit: object.from_currency,
                       separator: ",", delimiter: " ", format: "%n %u")
  end

  def to_amount_format
    number_to_currency(object.to_amount, unit: object.to_currency,
                       separator: ",", delimiter: " ", format: "%n %u")
  end
end
