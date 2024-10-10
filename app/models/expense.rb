class Expense < ApplicationRecord
  belongs_to :account
  validates :amount, numericality: { greater_than: 0 }
end
