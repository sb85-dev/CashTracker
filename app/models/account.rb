class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  has_many :invites
  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy

  # Ensure private accounts by default
  after_initialize :set_default_private

  def set_default_private
    self.private ||= true
  end

end
