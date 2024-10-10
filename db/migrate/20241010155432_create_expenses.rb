class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.string :category
      t.decimal :amount
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
