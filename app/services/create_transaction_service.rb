class CreateTransactionService
  include Callable

  attr_reader :transaction, :type

  def initialize(params, type)
    @transaction = Transaction.new(params)
    @type = type
  end

  def call
    transaction.manager = random_manager if type == 'extra'
    transaction.save
    transaction
  end

  private

  def random_manager
    @random_manager ||= Manager.order('RANDOM()').first
  end
end
