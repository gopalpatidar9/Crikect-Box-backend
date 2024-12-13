class Api::V1::DepositRequestsController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session
  
  def index
    deposit_requests = current_user.deposit_requests
    if deposit_requests
      render json: deposit_requests, status: :ok
    else
      render json: {error: 'Deposit Requests Not found'} , status: :not_found
    end
  end

  def users_deposit_requests
    user = User.find_by(params[:id])
    deposit_requests = user.deposit_requests
    if deposit_requests
      render json: deposit_requests, status: :ok
    else
      render json: {error: 'Deposit Requests Not Found'}, status: :not_found
    end
  end
  
  def send_request
    if current_user.user_role.role.name == 'Admin' || current_user.user_role.role.name == 'User'
      user = current_user.id
      deposit_request_status = DepositRequestStatus.find_by(name: 'Pending')
      parent_user = current_user.parent_user_id  
      request = DepositRequest.new(amount: params[:amount],
        message: params[:message], 
        user_id: user, 
        parent_user_id: parent_user,
        deposit_request_status_id: deposit_request_status.id
      )
      if request.save
        Notification.create(recipient_id: request.parent_user_id,
          sender_id: request.user_id,
          notification_type: 'Deposit Request',
          is_read: false, 
          message: "New deposit request received form #{request.user.name} 
            for an amount of Rs. #{request.amount} please assist with the processing"
        )  
        render json: request , status: :created
      else
        render json: request.erros, status: :unprocessable_entity
      end
    end
  end

  def approve_request
    request = find_deposit_request
    deposit_request_status = DepositRequestStatus.find_by(name: 'Approve')
    if request.update(deposit_request_status_id: deposit_request_status.id )
      if process_transaction(request)
        render json: request, status: :ok
      else
        render json: { error: 'Transaction could not be processed' }, status: :unprocessable_entity
      end
    else
      render json: request.errors, status: :unprocessable_entity
    end
  end

  def process_transaction(request)
    transaction_type = TransactionType.find_by(name: 'Deposit')
    user = current_user
    wallet = user.wallet
    treansferd_to_wallet = request.user.wallet

    transaction = Transaction.new(user_id: user.id, 
      wallet_id: wallet.id,
      transaction_type_id: transaction_type.id, 
      amount: request.amount,
      transferred_to: request.user_id
    )
    if transaction.save
      if wallet.balance >= request.amount
        update_wallet_balance(wallet, -request.amount) && update_wallet_balance(treansferd_to_wallet, request.amount)
      else
        false
      end
      Notification.create(recipient_id:transaction.transferred_to, 
        sender_id: transaction.user_id, 
        notification_type: "#{transaction_type.name} transaction",
        is_read: false, 
        message: "Amount Rs. #{transaction.amount} has been transferd on request approval"
      )
    else
      false
    end  
  end

  def update_wallet_balance(wallet, amount)
    new_balance = wallet.balance + amount
    wallet.update(balance: new_balance)
  end

  def reject_request
    request = find_deposit_request
    deposit_request_status = DepositRequestStatus.find_by(name: 'Reject')
    if request.update(deposit_request_status_id: deposit_request_status.id)
      Notification.create(recipient_id: request.user_id,
        sender_id: current_user.id,
        notification_type: "Deposit Request #{deposit_request_status.name}",
        is_read: false, 
        message: "Your deposit request for Rs. #{request.amount} has been rejected"
      )
      render json: request, status: :ok
    else
      render json: request.errors, status: :unprocessable_entity
    end
  end

  def superadmin_add_balance
    if current_user.user_role.role.name == 'SuperAdmin'
      user = current_user
      wallet = user.wallet
      deposit_request_status = DepositRequestStatus.find_by(name: 'Approve')
      request = DepositRequest.new(amount: params[:amount],
        message: params[:message],
        user_id: user.id
      )
      request.deposit_request_status_id = deposit_request_status.id  
      if request.save 
        wallet.update(balance: wallet.balance + request.amount)
        Notification.create(recipient_id: request.user_id,
          sender_id: current_user.id,
          notification_type: "Add Balance",
          is_read: false, 
          message: "You Add amount Rs. #{request.amount} in wallet"
        )
        render json: { success: true, message: "Balance added successfully" }, status: :ok
      else
        render json: request.erros, status: :unprocessable_entity
      end
    end
  end

  private
  
  def find_deposit_request
    DepositRequest.find_by(params[:id])
  end
end





# def user_send_request
  #   if current_user.user_role.role.name == 'User'
  #     user = current_user.id
  #     deposit_request_status = DepositRequestStatus.find_by(name: 'Pending')
  #     parent_user = current_user.parent_user_id
  #     request = DepositRequestStatus.new(amount: params[:amount],
  #       message: params[:message],
  #       user_id: user,
  #       parent_user_id: parent_user,
  #       deposit_request_status_id: deposit_request_status.id
  #     )
  #     if request.save
  #       Notification.create(recipient_id: request.parent_user_id,
  #         sender_id: request.user_id,
  #         notification_type: 'Deposit Request',
  #         is_read: false, 
  #         message: "New deposit request received form #{request.user.name} 
  #           for an amount of Rs. #{request.amount} please assist with the processing"
  #       )  
  #       render json: request, status: :created
  #     else
  #       render json: request.erros, status: :unprocessable_entity
  #     end
  #   end
  # end

  # def admin_approve_request
  #   request = find_deposit_request
  #   deposit_request_status = DepositRequestStatus.find_by(name: 'Approve')
  #   if request.update(deposit_request_status_id: deposit_request_status.id)
  #     if process_transaction(request)
  #       render json: request, status: :ok
  #     else
  #       render json: { error: 'Transaction could not be processed' }, status: :unprocessable_entity
  #     end
  #   else
  #     render json: request.errors, status: :unprocessable_entity
  #   end
  # end

  # def admin_reject_request
  #   request = find_deposit_request
  #   deposit_request_status = DepositRequestStatus.find_by(name: 'Rejected')
  #   if request.update(deposit_request_status_id: deposit_request_status.id)
  #     Notification.create(recipient_id: request.user_id,
  #       sender_id: current_user.id,
  #       notification_type: "Deposit Request #{deposit_request_status.name}",
  #       is_read: false, 
  #       message: "Your deposit request for Rs. #{request.amount} has been rejected"
  #     )
  #     render json: request, status: :ok
  #   else
  #     render json: request.errors, status: :unprocessable_entity
  #   end
  # end
