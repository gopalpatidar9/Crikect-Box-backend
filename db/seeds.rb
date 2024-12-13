# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

MatchStatus.create(name: "Scheduled" , order: 1 , is_active: true)
MatchStatus.create(name: "Completed" , order: 2 , is_active: true)
MatchStatus.create(name: "Live" , order: 3 , is_active: true)
MatchStatus.create(name: "canceled" , order: 4 , is_active: true)

Role.create(name: "SuperAdmin")
Role.create(name: "Admin")
Role.create(name: "User")

LiveOddsType.create(odds_type: "matchodds")
LiveOddsType.create(odds_type: "tiedmatch")
LiveOddsType.create(odds_type: "bookmaker")

superadmin_default_password = 'superadmin123'
user = User.create(name: "SuperAdmin" , email:"superadmin123@gmail.com",
  password: superadmin_default_password, password_confirmation: superadmin_default_password)
role = Role.find_by(name: 'SuperAdmin')
user_role = UserRole.create(user_id: user.id , role_id: role.id)
wallet = Wallet.create(user_id: user.id, balance: 0, lastupdated: Time.now)
user_detail = UserDetail.create(user_id: user, deposit_request_enabled: true,
  chats_enabled: true, can_add_user: true, bet_enabled:true)

DepositRequestStatus.create(name: 'Approve', order: 1, is_active: true)
DepositRequestStatus.create(name: 'Pending', order: 2, is_active: true)
DepositRequestStatus.create(name: 'Rejected', order: 3, is_active: true)

BetStatus.create(name: 'Pending', order: 1, is_active: true)
BetStatus.create(name: 'Completed', order: 2, is_active: true)
BetStatus.create(name: 'Cancle', order: 3, is_active: true)

TransactionType.create(name: 'Bet', order: 1, is_active: true)
TransactionType.create(name: 'Deposit', order: 1, is_active: true)
TransactionType.create(name: 'Withdrawal', order: 1, is_active: true)
TransactionType.create(name: 'Win', order: 1, is_active: true)
