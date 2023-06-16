class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all.includes(:manager).order(id: :desc).page(params[:page])
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new

    render "new_#{params[:type]}"
  end

  def create
    @transaction = Transaction.new(transaction_params)

    @manager = Manager.order('RANDOM()').first if params[:type] == 'extra'

    if @transaction.save
      redirect_to @transaction
    else
      render "new_#{params[:type]}"
    end
  end

  private

  def transaction_params
￼    params.require(:transaction).permit(:first_name, :last_name, :from_amount, :from_currency, :to_currency)
￼ end
end
