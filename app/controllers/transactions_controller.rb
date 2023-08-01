# frozen_string_literal: true

class TransactionsController < ApplicationController
  rescue_from 'ActiveRecord::RecordNotFound' do
    render plain: 'Inexistent transaction', status: :not_found
  end

  def index
    @pagy, @transactions = pagy(Transaction.all.includes(:manager))
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new

    render "new_#{size_type}"
  end

  def create
    @transaction = Transaction.new(params_for_create)
    @transaction.intended_size = size_type

    if @transaction.save
      redirect_to @transaction
    else
      render "new_#{size_type}"
    end
  end

  private

  def size_type
    (Transaction::ALLOWED_SIZES & [params[:type]]).first || 'small'
  end

  def params_for_create
    params.require(:transaction).permit(
      :first_name,
      :last_name,
      :from_currency,
      :to_currency,
      :from_amount
    )
  end
end
