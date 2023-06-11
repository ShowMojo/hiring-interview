require 'rails_helper'

RSpec.describe Transaction do
  # Better option will be to use Factory pattern here.
  subject { transaction }

  let(:manager) { Manager.create(first_name: 'Manager', last_name: 'Last') }
  let(:transaction) {
    described_class.create(first_name: 'Steren', last_name: 'Nausikaa', from_currency: 'USD',
                           to_currency: 'CAD', from_amount_cents: 200_000_000, manager:)
  }

  describe 'associations' do
    it { is_expected.to belong_to(:manager).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe '.large?' do
    it 'returns true if amount more then 100 USD' do
      expect(transaction.large?).to be true
    end
  end
end
