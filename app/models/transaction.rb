class Transaction < ApplicationRecord
  include Exchangable

  AVAILABLE_CURRENCIES = ['USD', 'GBP', 'AUD', 'CAD'].freeze
  TYPES = ['small', 'large', 'extra']

  belongs_to :manager, optional: true

  monetize :from_amount_cents, with_currency: ->(t) { t.from_currency }, numericality: { greater_than: 0 }
  monetize :to_amount_cents, with_currency: ->(t) { t.to_currency }

  validates :first_name, presence: true, if: [:large?, :extra_large?]
  validates :last_name, presence: true, if: [:large?, :extra_large?]

  before_create :generate_uid

  before_validation :assign_manager, if: :extra_large?

  delegate :full_name, to: :manager, allow_nil: true, prefix: :manager

  def client_full_name
    "#{first_name} #{last_name}"
  end

  private

  def generate_uid
    self.uid = SecureRandom.hex(5)
  end

  def assign_manager
    self.manager = Manager.order("RANDOM()").first
  end

end
