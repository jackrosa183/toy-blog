class AddShouldFbPostToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :should_fb_post, :boolean, default: false
  end
end
