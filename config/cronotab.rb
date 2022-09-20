# cronotab.rb — Crono configuration file
#
# Here you can specify periodic jobs and schedule.
# You can use ActiveJob's jobs from `app/jobs/`
# You can use any class. The only requirement is that
# class should have a method `perform` without arguments.
#
class CheckPublishing
  include Rails.application.routes.url_helpers
  def perform
    twitter_posts = Post.where(publish_date: Date.current).where(published: false).where(should_tweet: true)
    twitter_posts.each do |post|
      user = User.find_by(id: post.user_id)

      client = Twitter::REST::Client.new do |config|
        config.consumer_key = Rails.application.credentials.dig(:twitter, :api_key)
        config.consumer_secret = Rails.application.credentials.dig(:twitter, :api_secret)
        config.access_token        =  user.twitter_account.token
        config.access_token_secret =  user.twitter_account.secret
      end
      
      puts "today is publishing day " + post.title
      post.published = true
      post.save

      unless user.twitter_account.nil?
        puts "TWEEEET"
        client.update("Check out my new blogpost #{url_for(action: 'show', controller: 'posts', id: post.id, host: 'http://localhost:3000/')}")
      else
      end
    end

    fb_posts = Post.where(publish_date: Date.current).where(published: false).where(should_fb_post: true)
    fb_posts.each do |post|

      user = User.find_by(id: post.user_id)

      fb_user = Koala::Facebook::API.new('EAAGv2ZChErOIBAOTNUQTFP2i50wDm8ZCV0AcbYZBKtBtYnRdtZAo4VaX7Udd6ixiYSaHGMBKjC7yUXh5ZAcYM0suv3AbPuE1nNIsl7zHNUObEJ2iR0WLWt3aUituWZAcjS8RmB7A9BTgVHPWZA8NaIJlflJfpvv0DgyZBjKTzZAa7LgdMBtmCWhFhcShHqkpGlMr2WoyF6OUIewZDZD')
      # puts fb_user.get_connections("me", "feed").to_s
      fb_user.put_connections("me", "feed", message: "Check out my new blog post  #{url_for(action: 'show', controller: 'posts', id: post.id, host: 'http://localhost:3000/')}")
    end  
  end
end

Crono.perform(CheckPublishing).every 20.seconds

