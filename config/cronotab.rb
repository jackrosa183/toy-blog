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
      puts "today is publishing day " + post.title
      post.published = true
      post.save
      #if user has a connected twitter
        #tweet my post has been published!  
    end
  end
end

Crono.perform(CheckPublishing).every 5.seconds

