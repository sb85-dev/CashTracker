class CreateIncomes < ActiveRecord::Migration[7.2]
  def change
    create_table :incomes do |t|
      t.string :source
      t.decimal :amount
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
