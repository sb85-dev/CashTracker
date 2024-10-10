class CleanupOldImagesJob < ApplicationJob
  queue_as :default

  def perform
    Transaction.where('created_at < ?', 90.days.ago).find_each do |transaction|
      transaction.document.purge if transaction.document.attached?
    end
  end
end
