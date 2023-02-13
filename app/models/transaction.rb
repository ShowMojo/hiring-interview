class Transaction < ApplicationRecord
  include Transactionable

  belongs_to :manager, optional: true
  delegate :full_name, to: :manager, allow_nil: true, prefix: :manager
end
