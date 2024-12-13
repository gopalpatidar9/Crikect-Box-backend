class Api::V1::CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:show, :update, :destroy, :place_bet]
  
  def create
    @cart = current_user.crats.build(crat_params)
    if @cart.save 
      render json: @cart, status: :created
    else
      render json: @cart.errors, status: :unprocessable_entity  
    end
  end

  def show
    render json: @cart_item
  end
  
  def place_bets
    bet_status = BetStatus.find_by(name: 'Pending')

    if bet_status
      current_user.carts.each do |cart_item|
        bet = Bet.new(
          team_number: cart_item.team_number,
          odd_type: cart_item.odd_type,
          odd_value: cart_item.odd_value,
          team_name: cart_item.team_name,
          team_id: cart_item.team_id,
          mid: cart_item.mid,
          amount: cart_item.amount,
          user_id: current_user.id,
          match_title: cart_item.match_title,
          bet_status_id: bet_status.id,
          live_odds_type_id: cart_item.live_odds_type_id,
          match_id: cart_item.match_id
        )
        if current_user.wallet.balance >= bet.amount 
          if bet.save
            transaction_type = TransactionType.find_by(name: 'Bet')
            transaction = Transaction.new(
              user_id: current_user.id, 
              wallet_id: current_user.wallet.id,
              transaction_type_id: transaction_type.id, 
              amount: bet.amount,
              transferred_to: bet.id)
            if transaction.save
              current_user.wallet.update(
                balance: current_user.wallet.balance - bet.amount
              )
              Notification.create(
                recipient_id: current_user.id , 
                sender_id: bet.user_id, 
                message: "Rs. #{bet.amount} has been debited from your account for your bet placement", 
                notification_type: "Palce Bet", 
                is_read: false
              )
            end  
            render json: bet, status: :created
          else
          end
        end
      end
      current_user.carts.destroy_all
      head :no_content
    else
      render json: { error: 'Bet status not found' }, status: :unprocessable_entity
    end
  end

  def destroy
    @cart_item.destroy
    head :no_content
  end

  def clear
    current_user.carts.destroy_all
    head :no_content
  end

  private
  
  def set_cart_item
    @cart_item = current_user.bets.find(params[:id])
  end

  def crat_params
    params.require(:cart).permit(:team_number, :odd_type, :odd_value, :team_name, :team_id, :mid, :match_title, :live_odds_type, :match_id, :amount)
  end
end
