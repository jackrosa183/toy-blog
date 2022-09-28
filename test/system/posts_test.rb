require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do 
    login_as users(:admin)
    @post = Post.published.last
  end

  test "user can see their own unpublished posts" do
    travel_to Time.new(2022, 9, 14) do
      login_as users(:john)

      visit index_drafts_path

      assert_selector "h2", text: "futuristic post (Unpublished) until 2022-09-15"
      assert_no_selector "h2", text: "janes second post (Unpublished) until 2022-09-15"
    end

  end

  test "comment actions redirect to the current page" do 
    # @post = posts(five)

    visit "posts/?page=2"
    fill_in "comment_content", with: "Cool post!", match: :first
    click_on "Comment", match: :first 
    assert_current_path "/posts/?page=2"

    click_on "Delete Comment"
    assert_current_path "/posts/?page=2"
  end

  test "creating a new post" do
    travel_to Time.new(2022, 9, 14) do
      visit posts_path
      click_on "Create Post"

      fill_in "Title", with: "Test Title"
      fill_in "Content", with: "Test Content"

      fill_in "post[publish_date]", with: "09142022"
      fill_in "Search Tags", with: "yeet " 
      # sleep 100
      click_on "Create Post"



      assert_current_path posts_path

      # assert_text "yeet"
      assert_text "2022-09-14"
      assert_selector "h2", text: "Test Title"
      assert_selector "p", text: "Test Content"
    end
  end

  test "posts publish on the correct day" do
    travel_to Time.new(2022, 9, 14) do
      login_as users(:john)

      visit posts_path

      assert_no_text "futuristic post"
    end

    travel_to Time.new(2022, 9, 15) do
      login_as (users(:john))
      visit posts_path
      assert_text "futuristic post"
    end
  end

  test "deleting a post" do
    post = posts(:one)
    login_as users(:john)
    visit posts_path
    assert_text post.content

    click_on "Delete", match: :first
    assert_current_path posts_path
    assert_no_text post.content
  end

  test "editing a post" do
    login_as users(:john)

    visit posts_path
    click_on "Edit", match: :first
    fill_in "Title", with: "yeet"
    fill_in "Content", with: "yote"

    click_on "Update Post"
    assert_current_path posts_path
    assert_selector "h2", text: "yeet"
    assert_selector "p", text: "yote"
  end
end
