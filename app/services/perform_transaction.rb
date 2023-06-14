class PerformTransaction
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    @transaction = Transaction.new(params)
    generate_uid
    assign_manager
    RefreshRates.new.call
    convert
    @transaction.save
    @transaction
  end

  private

  def generate_uid
    uid =  SecureRandom.hex(5)
    unless Transaction.exists?(uid:)
      @transaction.uid = uid
      return
    end
    # UID already exists. Try again
    generate_uid
  end

  def assign_manager
    return unless @transaction.extra_large?

    @transaction.manager = Manager.order('RANDOM()').first
  end

  def convert
    @transaction.to_amount = @transaction.from_amount.exchange_to(@transaction.to_currency)
  end
end
