class AddShouldTweetToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :should_tweet, :boolean, default: false
  end
end
