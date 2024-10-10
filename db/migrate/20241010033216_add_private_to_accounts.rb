class AddPrivateToAccounts < ActiveRecord::Migration[7.2]
  def change
    add_column :accounts, :private, :boolean
  end
end
