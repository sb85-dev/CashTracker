class Transaction < ApplicationRecord
  belongs_to :account

  # Ensure the transaction_type is either 'deposit' or 'withdrawal'
  validates :transaction_type, inclusion: { in: %w(deposit withdrawal) }

  # Ensure the amount is greater than 0
  validates :amount, numericality: { greater_than: 0}

  # Set up Active Storage for the document
  has_one_attached :document

  after_create :update_account_balance
  after_create :notify_followers

  private

  def update_account_balance
    if transaction_type == 'deposit'
      account.update(balance: account.balance + amount)
    elsif transaction_type == 'withdrawal'
      account.update(balance: account.balance - amount)
    end
  end
  
  def notify_followers
    NotifyFollowersJob.perform_later(self)
  end

end
