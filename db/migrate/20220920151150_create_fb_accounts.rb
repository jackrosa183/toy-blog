class CreateFbAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :fb_accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :email, uniqueness: true
      t.string :name
      t.string :uid
      t.string :token

      t.timestamps
    end
  end
end
