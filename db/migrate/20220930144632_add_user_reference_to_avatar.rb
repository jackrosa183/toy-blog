class AddUserReferenceToAvatar < ActiveRecord::Migration[7.0]
  def change
    add_reference :avatars, :user, null: true, foreign_key: true
  end
end
