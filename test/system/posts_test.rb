require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do 
    login_as users(:admin)
    @post = Post.last
  end

  test "creating a new post" do
    visit posts_path
    click_on "Create Post"

    fill_in "Title", with: "Test Title"
    fill_in "Content", with: "Test Content"
    click_on "Create Post"

    assert_selector "h2", text: "Test Title"
    assert_selector "p", text: "Test Content"
  end

  test "deleting a post" do
    visit posts_path

    assert_text @post.content
    click_on "Delete", match: :first
    assert_no_text @post.content
  end

  test "editing a post" do
    login_as users(:john)

    visit posts_path
    click_on "Edit", match: :first
    fill_in "Title", with: "yeet"
    fill_in "Content", with: "yote"

    click_on "Update Post"

    assert_selector "h2", text: "yeet"
    assert_selector "p", text: "yote"
  end
end
