class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validates :balance, presence: true
  # validates :lastupdated, presence: true
  
  before_save :set_lastupdated

  private

  def set_lastupdated
    self.lastupdated = Time.current
  end 
end
