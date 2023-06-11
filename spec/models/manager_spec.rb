require 'rails_helper'

RSpec.describe Manager do
  # Better option will be to use Factory pattern here.
  let(:manage) { described_class.new(first_name: 'first name', last_name: 'last name') }

  describe 'associations' do
    it { is_expected.to have_many(:transactions) }
  end

  describe '.full_name' do
    it 'returns full name' do
      expect(manage.full_name).to eq 'first name last name'
    end
  end
end
