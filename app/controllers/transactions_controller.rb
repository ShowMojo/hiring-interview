class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find_by(uid: params[:id])

    if @transaction.nil?
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def new
    @transaction = Transaction.new

    render "new_#{params[:type]}"
  end

  def create
    @transaction = "Transaction::#{params[:type].camelcase}".constantize.new(transaction_params)
    @transaction.manager = Manager.all.sample if params[:type] == 'extra'

    if @transaction.save
      redirect_to transaction_path(@transaction.uid)
    else
      render "new_#{params[:type]}"
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:first_name, :last_name, :from_amount, :from_currency, :to_currency)
  end
end
