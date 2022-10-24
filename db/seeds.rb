# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "\n== Seeding the database with fixtures =="

system("bin/rails db:fixtures:load")
posts = []
(1..50).each do |id|
  post = Post.create!(
    title: Faker::Mountain.name,
    user: User.all.sample,
    rich_content: Faker::Mountain.range,
    publish_date: Date.today - rand(10000)
  )
  posts << post
end

posts.each do |post|
  id = post.id
  post.update!(
    rich_content: ActionText::RichText.create!(record_type: 'Post', body: Faker::Mountain.range, name: id.to_s, record_id: id)
  )
end

(1..100).each do |id|
  Comment.create!(
    post_id: Post.all.sample.id,
    user_id: User.all.sample.id,
    content: [Faker::Games::SuperMario.character, Faker::Games::SuperMario.location].join(' ')
  )
end
