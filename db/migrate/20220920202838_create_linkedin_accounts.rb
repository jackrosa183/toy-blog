class CreateLinkedinAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :linkedin_accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true

      t.string :name, null: false
      t.string :uid, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
