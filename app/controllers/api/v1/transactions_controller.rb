class Api::V1::TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    transactions = current_user.transactions.order(created_at: :desc).paginate(page: params[:page], per_page: 10)

    if transactions
      render json: transactions, meta: pagination_meta(transactions), status: :ok
    else
      render json: { error: 'User transaactions not found' }, status: :not_found
    end
  end

  private

  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      # prev_page: collection.prev_page,
      total_pages: collection.total_pages
      # total_count: collection.total_count
    }
  end
end 
