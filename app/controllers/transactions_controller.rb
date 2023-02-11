class TransactionsController < ApplicationController
  before_action :transaction, only: :show

  def index
    @pagy, @transactions = pagy(Transaction.order(id: :desc))
    @transactions = TransactionDecorator.decorate(@transactions)
  end

  def show
  end

  def new
    @transaction = Transaction.new
    request.variant = determine_variant
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to @transaction
    else
      render "new"
    end
  end

  private

  def transaction_params
    params[:transaction].permit(:first_name, :last_name, :from_amount, :from_currency, :to_currency)
  end

  def determine_variant
    %w[small large extra].include?(params[:type]) ? params[:type].to_sym : :small
  end

  def transaction
    @transaction ||= Transaction.find(params[:id])
  end
end
