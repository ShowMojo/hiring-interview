class TransactionsController < ApplicationController
  def index
    @transactions = TransactionDecorator.decorate_collection(Transaction.includes(:manager).all)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new

    render "new_#{params[:type]}"
  end

  def create
    @transaction = Transaction.new(params[:transaction].permit!)

    if params[:type] == 'extra'
      manager = @manager = Manager.order('RANDOM()').first
      @transaction.manager = manager
    end

    if @transaction.save
      redirect_to @transaction
    else
      render "new_#{params[:type]}"
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:first_name, :last_name, :from_amount, :from_currency, :to_currency)
  end
end
