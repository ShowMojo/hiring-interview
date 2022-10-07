class TransactionsController < ApplicationController
  before_action :set_new_form, only: [:new, :new_large, :new_extra_large]
  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    render "new_#{params[:type]}"
  end

  def new_large
  end

  def new_extra_large
  end

  def create
    @form = form.new(permited_params)

    if @form.save
      redirect_to @form.transaction
    else
      render "new_#{params[:type]}"
    end
  end

  private

  def permited_params
    params.require(:transaction).permit(:first_name, :last_name, :from_currency, :to_currency, :from_amount)
  end

  def set_new_form
    @form = form.new
  end

  def form
    case params[:type]
    when "extra"
      ExtraTransactionForm
    when "large"
      LargeTransactionForm
    else
      SmallTransactionForm
    end
  end
end
