Organization.find_each do |org|
  schema = org.database

  unless Apartment.tenant_names.include?(schema)
    Apartment::Tenant.create(schema)
  end

  Apartment::Tenant.switch!(schema) do
    MatchStatus.create(name: "Scheduled", order: 1, is_active: true)
    MatchStatus.create(name: "Completed", order: 2, is_active: true)
    MatchStatus.create(name: "Live", order: 3, is_active: true)
    MatchStatus.create(name: "Canceled", order: 4, is_active: true)

    Role.create(name: "SuperAdmin")
    Role.create(name: "Admin")
    Role.create(name: "User")

    LiveOddsType.create(odds_type: "matchodds")
    LiveOddsType.create(odds_type: "tiedmatch")
    LiveOddsType.create(odds_type: "bookmaker")

    superadmin_default_password = 'superadmin123'
    user = User.create!(
      name: "SuperAdmin",
      email: "superadmin123@gmail.com",
      password: superadmin_default_password,
      password_confirmation: superadmin_default_password
    )

    role = Role.find_by(name: 'SuperAdmin')
    UserRole.create(user_id: user.id, role_id: role.id)
    Wallet.create(user_id: user.id, balance: 0, lastupdated: Time.now)
    UserDetail.create(user_id: user.id, deposit_request_enabled: true,
                      chats_enabled: true, can_add_user: true, bet_enabled: true)

    DepositRequestStatus.create(name: 'Approve', order: 1, is_active: true)
    DepositRequestStatus.create(name: 'Pending', order: 2, is_active: true)
    DepositRequestStatus.create(name: 'Rejected', order: 3, is_active: true)

    BetStatus.create(name: 'Pending', order: 1, is_active: true)
    BetStatus.create(name: 'Completed', order: 2, is_active: true)
    BetStatus.create(name: 'Cancel', order: 3, is_active: true)

    TransactionType.create(name: 'Bet', order: 1, is_active: true)
    TransactionType.create(name: 'Deposit', order: 2, is_active: true)
    TransactionType.create(name: 'Withdrawal', order: 3, is_active: true)
    TransactionType.create(name: 'Win', order: 4, is_active: true)
  end
end
