class TransactionsController < ApplicationController
  def index
    @transactions = TransactionDecorator.decorate_collection(Transaction.includes(:manager).all)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new

    render "new_#{transaction_type}"
  end

  def create
    @transaction = CreateTransactionService.call(transaction_params)

    if @transaction.persisted?
      redirect_to @transaction
    else
      render "new_#{transaction_type}"
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:type, :first_name, :last_name, :from_amount, :from_currency, :to_currency)
  end

  def transaction_type
    params[:type]
  end
end
