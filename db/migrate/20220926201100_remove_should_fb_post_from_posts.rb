class RemoveShouldFbPostFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :should_fb_post, :boolean
  end
end
