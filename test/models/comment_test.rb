require "test_helper"

class CommentTest < ActiveSupport::TestCase

  setup do
    @user = User.create(email: "eric@example.com", password: "passwword")
    @post = Post.create(title: "Title", rich_content: "Content", user: @user, publish_date: Date.current.yesterday)
  end
  
  test "Comment post validations" do    
    comment = Comment.create(content: "comments are cool")
    
    assert comment.invalid?
    assert comment.errors.where(:user_id, :blank).present?
    assert comment.errors.where(:post_id, :blank).present?

    comment = Comment.create(content: "comments", user_id: @user.id, post_id: @post.id)
    assert comment.valid?
  end

  test "comment cannot be too large" do 
      big_string = "a" * 1000
      comment = Comment.create(content: big_string, user_id: @user.id, post_id: @post_id)
      assert comment.invalid?
      assert comment.errors.where(:content, :too_long).present?
  end
end
