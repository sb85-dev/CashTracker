class NotifyFollowersJob < ApplicationJob
  queue_as :default

  def perform(transaction)
    if transaction.account.followers.any?
      TransactionMailer.with(transaction: transaction).new_transaction_email.deliver_now
    else
      Rails.logger.info "Transaction created but no followers to notify."
    end
  end
  
end
