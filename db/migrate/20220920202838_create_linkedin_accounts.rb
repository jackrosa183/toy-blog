class CreateLinkedinAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :linkedin_accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true

      t.string :code

      t.timestamps
    end
  end
end
