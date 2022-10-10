class AddViewcountToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :viewcount, :integer, default: 0
  end
end
