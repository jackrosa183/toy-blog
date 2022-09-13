require "test_helper"

class CommentTest < ActiveSupport::TestCase

  setup do
    @user = User.create(email: "eric@example.com", password: "passwword")
    @post = Post.create(title: "Title", content: "Content", user: @user)
  end

  test "Comment post validations" do
    comment = Comment.create(content: "comments are cool")
    assert comment.invalid?
    assert comment.errors.where(:user_id, :blank).present?
    assert comment.errors.where(:post_id, :blank).present?

    comment = Comment.create(content: "comments", user_id: @user.id, post_id: @post.id)
    assert comment.valid?
  end
end
