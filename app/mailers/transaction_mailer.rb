class TransactionMailer < ApplicationMailer
    def new_transaction_email(follower, transaction)
        @follower = follower
        @transaction = transaction
        mail(to: @follower.email, subject: 'New Transaction Alert')
    end    
end
