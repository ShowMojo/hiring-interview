class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
    @manager = Manager.find_less_loaded

    render "new_#{params[:type]}"
  end

  def new_large
    @transaction = Transaction.new
  end

  def new_extra_large
    @transaction = Transaction.new
    @manager = Manager.find_less_loaded
  end

  def create
    @transaction = Transaction.new(create_params)

    if @transaction.save
      redirect_to @transaction
    else
      render "new_#{params[:type]}"
    end
  end

  private

  def create_params
    params.require(:transaction).permit(:manager_id, :first_name, :last_name, :from_amount, :from_currency, :to_currency)
  end
end
