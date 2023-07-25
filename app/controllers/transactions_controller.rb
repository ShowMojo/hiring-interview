class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.includes(:manager).all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
    @manager = random_manager

    render new_template_name
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to @transaction
    else
      render new_template_name
    end
  end

  private

  def new_template_name
    return "new_#{params[:type]}" if params[:type].in?(%w[small large extra])

    'new_small'
  end

  def random_manager
    Manager.order('RANDOM()').limit(1).first if params[:type] == 'extra'
  end

  def transaction_params
    params.require(:transaction).permit(:first_name, :last_name, :from_currency, :to_currency, :from_amount, :manager_id)
  end
end
