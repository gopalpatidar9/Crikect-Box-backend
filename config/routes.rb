Rails.application.routes.draw do
  
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do
      resources :wallets, only: [:index]
      post 'add_new_user', to: 'add_users#add_new_user'
      get 'users_list', to: 'add_users#users_list'
      get 'show_user_added_list', to: 'add_users#show_user_added_list'
      get 'chat_room', to: 'add_users#show_chat_room'
      get 'my_users_user_detial', to: 'add_users#my_users_user_detial'
      put 'users/:id/update', to: 'add_users#user_update', as: 'user_update'
      get 'live_odds/team_a_odds'
      get 'live_odds/team_b_odds'
      post 'sign_in', to: 'sessions#create'
      resources :organizations, only: [:index, :show, :create, :destroy]
      resources :competitions, only: [:index, :show ]
      resources :matches, only: [:index, :show ]
      get "user_roles/current_user_role"
      get 'matches/team_a_s'
      get 'chat_room', to: 'add_users#chat_room'
      resources :carts, only: [:show, :create, :destroy] do
        collection do
          post :place_bet
          delete :clear
        end
      end
      resources :user_details, only: [:index, :show, :update]
      resources :bets, only: [:index, :show, :create]  
      resources :transactions, only: [:index]

      resources :deposit_requests, only: [:index] 
        
      post 'send_request', to: 'deposit_requests#send_request'
      post 'approve_request', to: 'deposit_requests#approve_request'
      post 'reject_request', to: 'deposit_requests#reject_request'
      post 'superadmin_add_balance', to: 'deposit_requests#superadmin_add_balance'
        
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
