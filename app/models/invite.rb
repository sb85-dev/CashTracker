class Invite < ApplicationRecord
  belongs_to :account
  belongs_to :user

  # Generate a unique token for the invite
  before_create :generate_token

  def generate_token
    self.token = SecureRandom.hex(10)
  end
  
end
