class CreateInvites < ActiveRecord::Migration[7.2]
  def change
    create_table :invites do |t|
      t.references :account, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :token
      t.string :status

      t.timestamps
    end
  end
end
