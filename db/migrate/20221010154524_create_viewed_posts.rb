class CreateViewedPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :viewed_posts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :post_ids, array: true, default: [], index: { unique: true }

      t.timestamps
    end
  end
end