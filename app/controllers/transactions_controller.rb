class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.includes(:manager).last(10)
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
    # hadn't checked - copilot added permitted params
    params
      .require(:transaction)
      .permit(
        :first_name, :last_name, :from_amount, :from_currency, :to_amount,
        :to_currency, :manager_id
      )
  end
end
