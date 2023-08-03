class TransactionsController < ApplicationController
  before_action :set_managers, only: %i[new create]

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

  def create
    @transaction = Transaction.subclass_for(params[:type]).new(transaction_params)

    if @transaction.save
      redirect_to transaction_path(@transaction)
    else
      render "new_#{params[:type]}"
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(
      :first_name,
      :last_name,
      :from_amount,
      :from_currency,
      :to_currency,
      :manager_id
    )
  end

  def set_managers
    @managers = Manager.all
  end
end
