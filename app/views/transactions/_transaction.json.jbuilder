json.extract! transaction, :id, :amount, :transaction_type, :notes, :account_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
