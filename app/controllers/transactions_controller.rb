class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
    render "new_#{transaction_type}"
  end

  # def new_large # we don't need this methods as they aren't used anywhere and are non-crud approach
  #   @transaction = Transaction.new
  # end
  #
  # def new_extra_large
  #   @transaction = Transaction.new
  #   @manager = Manager.all.sample
  # end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.manager_id = random_manager.id if params[:type] == 'extra'

    if @transaction.save!
      redirect_to @transaction
    else
      render "new_#{transaction_type}"
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:first_name, :last_name, :from_currency, :to_currency, :from_amount)
  end

  def random_manager
    #https://stackoverflow.com/questions/2752231/random-record-in-activerecord#:~:text=If%20you%20have%20100k%20rows%20in%20your%20database%2C%20all%20of%20these%20would%20have%20to%20be%20loaded%20into%20memory.
    #INFO: we don't actually need separate method for it, but for me, that way would be easier for understanding.
    Manager.order("RANDOM()").limit(1).first
  end

  def transaction_type
    @transaction_type ||= params[:type] # should be used for each transaction
  end
end
