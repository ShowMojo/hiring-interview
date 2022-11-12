class TransactionsController < ApplicationController
  def index
    @pagy, @transactions = pagy(Transaction.all)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to @transaction
    else
      render :new
    end
  end

  private

  def transaction_params
    params[:transaction].permit(:first_name, :last_name, :from_amount, :from_currency, :to_currency)
  end
end
