class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[new create]

  def index
    @transactions = Transaction.includes(:manager).all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    render "new_#{params[:type]}"
  end

  def create
    @transaction.assign_attributes(transaction_attributes)

    @transaction.manager = Manager.order('random()').first if params[:type] == 'extra'

    if @transaction.save
      redirect_to @transaction
    else
      new
    end
  end

  private

  def set_transaction
    @transaction = Transaction.new
  end

  def transaction_attributes
    params.require(:transaction).permit :first_name, :last_name, :from_amount, :from_currency, :to_currency
  end
end
