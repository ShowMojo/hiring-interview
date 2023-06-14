class RefreshRates
  UPDATE_FREQUENCY = 1.hour

  def call
    return if bank.rates_updated_at && bank.rates_updated_at < UPDATE_FREQUENCY.ago

    invalidate_cache
    update_cache
  end

  private

  def update_cache
    rates = Rails.cache.fetch 'money:eu_central_bank_rates' do
      bank.save_rates_to_s
    end
    bank.update_rates_from_s rates
  end

  def invalidate_cache
    Rails.cache.delete('money:eu_central_bank_rates')
  end

  def bank
    Money.default_bank
  end
end
