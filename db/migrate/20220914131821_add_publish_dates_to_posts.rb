class AddPublishDatesToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :publish_date, :date
  end
end
