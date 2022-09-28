class FeedController < ActionController::Base

  def json_feed
    posts = []
    Post.ordered.each do |post|
      post_hash = {}
      post_hash[:title] = post.title
      post_hash[:content] = post.content
      post_hash[:email] =  post.user.email
      post_hash[:time_stamp] = post.created_at
      posts << post_hash
    end
    render json: posts
  end
  def rss 
    respond_to do |format|
      format.html
      format.xml { render :layout => false }
    end
  end
end