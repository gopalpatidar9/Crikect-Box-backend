class ChangeColumnNameInUserDetails < ActiveRecord::Migration[7.0]
  def change
    rename_column :user_detail, :CanAddUser, :can_add_user
    rename_column :user_detail, :BetEnabled, :bet_enabled
    rename_column :user_detail, :chatsenabled, :chats_enabled
    rename_column :user_detail, :depositrequestenabled, :deposit_request_enabled
  end
end
