class Manager < ApplicationRecord
  has_many :transactions, dependent: :restrict_with_error

  def full_name
    "#{first_name} #{last_name}"
  end
end
