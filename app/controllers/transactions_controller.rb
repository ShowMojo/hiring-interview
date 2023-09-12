class TransactionsController < ApplicationController
  before_action :build_transaction, only: %i[new new_large new_extra_large]

  def index
    @transactions = Transaction.includes(:manager).all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    render "new_#{params[:type]}"
  end

  def new_large; end

  def new_extra_large; end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.extra_large?
    @transaction.manager = Manager.order('RANDOM()').limit(1).last
    end
    
    if @transaction.save
      redirect_to @transaction
    else
      render "new_#{params[:type]}"
    end
  end

  private

  def build_transaction
    @transaction = Transaction.new
  end

  def transaction_params
    params
      .require(:transaction)
      .permit(:first_name, :last_name, :from_amount, :from_currency, :to_currency, :type)
  end
end
