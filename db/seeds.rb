Organization.find_each do |org|
  schema = (org.database.presence || org.name).parameterize.underscore
  next if schema.blank?  # Guard against any bad data

  unless Apartment.tenant_names.include?(schema)
    Apartment::Tenant.create(schema)
  end

  Apartment::Tenant.switch!(schema) do
    MatchStatus.find_or_create_by(name: "Scheduled") { |s| s.order = 1; s.is_active = true }
    MatchStatus.find_or_create_by(name: "Completed") { |s| s.order = 2; s.is_active = true }
    MatchStatus.find_or_create_by(name: "Live")      { |s| s.order = 3; s.is_active = true }
    MatchStatus.find_or_create_by(name: "Canceled")  { |s| s.order = 4; s.is_active = true }

    Role.find_or_create_by(name: "SuperAdmin")
    Role.find_or_create_by(name: "Admin")
    Role.find_or_create_by(name: "User")

    LiveOddsType.find_or_create_by(odds_type: "matchodds")
    LiveOddsType.find_or_create_by(odds_type: "tiedmatch")
    LiveOddsType.find_or_create_by(odds_type: "bookmaker")

    user = User.find_or_create_by(email: "superadmin123@gmail.com") do |u|
      u.name = "SuperAdmin"
      u.password = 'superadmin123'
      u.password_confirmation = 'superadmin123'
    end

    role = Role.find_by(name: 'SuperAdmin')
    if role.present?
      UserRole.find_or_create_by(user_id: user.id, role_id: role.id)
    else
      Rails.logger.warn "SuperAdmin role not found while seeding user role"
    end

    Wallet.find_or_create_by(user_id: user.id) do |w|
      w.balance = 0
      w.lastupdated = Time.now
    end

    UserDetail.find_or_create_by(user_id: user.id) do |ud|
      ud.deposit_request_enabled = true
      ud.chats_enabled = true
      ud.can_add_user = true
      ud.bet_enabled = true
    end

    DepositRequestStatus.find_or_create_by(name: 'Approve') { |s| s.order = 1; s.is_active = true }
    DepositRequestStatus.find_or_create_by(name: 'Pending') { |s| s.order = 2; s.is_active = true }
    DepositRequestStatus.find_or_create_by(name: 'Rejected'){ |s| s.order = 3; s.is_active = true }

    BetStatus.find_or_create_by(name: 'Pending')   { |s| s.order = 1; s.is_active = true }
    BetStatus.find_or_create_by(name: 'Completed') { |s| s.order = 2; s.is_active = true }
    BetStatus.find_or_create_by(name: 'Cancel')    { |s| s.order = 3; s.is_active = true }

    TransactionType.find_or_create_by(name: 'Bet')        { |s| s.order = 1; s.is_active = true }
    TransactionType.find_or_create_by(name: 'Deposit')    { |s| s.order = 2; s.is_active = true }
    TransactionType.find_or_create_by(name: 'Withdrawal') { |s| s.order = 3; s.is_active = true }
    TransactionType.find_or_create_by(name: 'Win')        { |s| s.order = 4; s.is_active = true }

  end
end
