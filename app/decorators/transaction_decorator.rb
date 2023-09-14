class TransactionDecorator < Draper::Decorator
  delegate_all

  decorates_association :manager

  def client_full_name
    "#{first_name} #{last_name}"
  end
end
