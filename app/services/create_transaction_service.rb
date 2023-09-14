class CreateTransactionService
  include Callable

  def initialize(params)
    @transaction = Transaction.new(params)
  end

  def call
    @transaction.manager = random_manager if @transaction.extra_large?
    @transaction.save
    @transaction
  end

  private

  def random_manager
    @random_manager ||= Manager.order('RANDOM()').first
  end
end
