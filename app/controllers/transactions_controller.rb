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

  def create
    @transaction = Transaction.new(params[:transaction].permit!)

    @transaction.manager = Manager.order('random()').first if params[:type] == 'extra'

    if @transaction.save
      redirect_to @transaction
    else
      render "new_#{params[:type]}"
    end
  end
end
