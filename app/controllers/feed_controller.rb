class FeedController < ActionController::Base

  def json_feed
    posts = []
    Post.ordered.each do |post|
      post_hash = {}
      post_hash[:title] = post.title
      post_hash[:rich_content] = post.rich_content
      post_hash[:email] =  post.user.email
      post_hash[:time_stamp] = post.created_at
      posts << post_hash
    end
    render json: posts
  end

  def rss 
    @posts = Post.ordered[0..5]
  end
end