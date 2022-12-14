require "test_helper"

class PostTest < ActiveSupport::TestCase

  setup do
    @user = User.create(email: "eric@example.com", password: "password")
  end

  test "Posts are correctly published" do
    post_1 = Post.create(title: "published", rich_content: "published content", created_at: 5.minutes.ago, user: @user, publish_date: Date.current.tomorrow)
    post_2 = Post.create(title: "second title", rich_content: "first content", created_at: 5.minutes.ago, user: @user, publish_date: Date.current.tomorrow)
    
    assert_not_equal @user.posts.published, [post_1, post_2]

    post_1.update(publish_date: Date.current)
    assert_equal @user.posts.published, [post_1]
  end

  test "Posts are in descending order" do
    post_3 = Post.create(title: "first title", rich_content: "first content", created_at: 10.minutes.ago, user: @user, publish_date: Date.current.yesterday)
    post_1 = Post.create(title: "third title", rich_content: "third content", created_at: 3.minutes.ago, user: @user, publish_date: Date.current.yesterday)
    post_2 = Post.create(title: "second title", rich_content: "second title", created_at: 5.minutes.ago, user: @user, publish_date: Date.current.yesterday)

    assert_equal @user.posts.ordered, [post_1, post_2, post_3]
  end 

  test "Posts have users validations" do

    post_1 = Post.new(title: "third title", rich_content: "third content", created_at: 3.minutes.ago)
    assert post_1.invalid?

    assert post_1.errors.where(:user, :blank).present? 

    post_1 = Post.new(title: "third title", rich_content: "third content", created_at: 3.minutes.ago, user: @user, publish_date: Date.current.yesterday)
    assert post_1.valid?
    assert_not post_1.errors.where(:user, :blank).present? 
  end

  test "Posts have title validations" do
    post_1 = Post.new(created_at: 3.minutes.ago, user: @user) 
    assert post_1.invalid?

    assert post_1.errors.where(:title, :blank).present?
  end

  test "Posts have content validations" do
    post_1 = Post.new(title: "third title", created_at: 3.minutes.ago, user: @user)
    assert post_1.invalid?
    assert post_1.errors.where(:rich_content, :blank).present?
  end

  test "Post gets correct extracted tags" do
    post_1 = posts(:one)
    post_1.extracted_tags = ["ruby", "rails"]
    puts post_1.tags.map(&:title)

    assert_equal 2, post_1.reload.tags.count
  end

  test "Posts are ranked by popularity" do
    posts(:one).viewcount = Post.popularity.first.viewcount + 1000
    posts(:one).save
    assert Post.popularity.first, posts(:one)
  end
end
