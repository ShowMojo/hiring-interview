# frozen_string_literal: true

class Manager < ApplicationRecord
  has_many :transactions, dependent: :nullify,
                          inverse_of: :manager

  validates :first_name, presence: true
  validates :last_name, presence: true
end
