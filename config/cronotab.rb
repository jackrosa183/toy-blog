# cronotab.rb — Crono configuration file
#
# Here you can specify periodic jobs and schedule.
# You can use ActiveJob's jobs from `app/jobs/`
# You can use any class. The only requirement is that
# class should have a method `perform` without arguments.
#
class CheckPublishing
  
  def perform
    posts = Post.where(publish_date: Date.current).where(published: false)
    posts.each do |post|
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
        client.update("Check out my new blogpost  #{post.title}")
      else
      end
    end
  end
end

Crono.perform(CheckPublishing).every 5.seconds

