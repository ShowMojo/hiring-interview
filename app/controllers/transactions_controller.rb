class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[new create]

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    render "new_#{params[:type]}"
  end

  def create
    @transaction.assign_attributes(params[:transaction].permit!)

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
end
