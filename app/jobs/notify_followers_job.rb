class NotifyFollowersJob < ApplicationJob
  queue_as :default

  def perform(transaction)
    transaction.account.followers.each do |follower|
      TransactionMailer.new_transaction_email(follower, transaction).deliver_later
    end
  end
  
end
