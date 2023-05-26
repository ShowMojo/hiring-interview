class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new

    render "new_#{params[:type]}"
  end

  def new_large
    @transaction = Transaction.new
  end

  def new_extra_large
    @transaction = Transaction.new
    @manager = Manager.all.sample
  end

  def create
    @transaction = Transaction.new(transaction_params)

    @manager = Manager.all.sample if params[:type] == 'extra'

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
