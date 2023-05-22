class Manager < ApplicationRecord
  has_many :transactions

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_less_loaded
    Manager.left_joins(:transactions).group(:id).order('COUNT(transactions.id)').first
  end
end
