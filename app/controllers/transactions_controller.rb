class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.includes(:manager)
                               .page(page)
                               .per(per_page)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
    @manager = Manager.all.sample

    render "new_#{params[:type]}"
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

  def index_params
    params.permit(:page, :per_page)
  end

  def page
    params[:page] || 0
  end

  def per_page
    params[:per_page] || 5
  end
end
