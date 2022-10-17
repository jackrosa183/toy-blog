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
    visit post_path(Post.published.last.id)
    
    fill_in "comment_content", with: "Cool post!", match: :first
    
    click_on "Comment", match: :first 
    
    assert_current_path post_path(Post.published.last.id)
    
    assert_text "Cool post!", maximum: 1
    
    click_on "Delete Comment"
    
    assert_current_path post_path(Post.published.last.id)
    
    assert_no_text "Cool post!"
  end

  test "creating a new post" do
    travel_to Time.new(2022, 9, 14) do
      visit posts_path
      
      click_on "Create Post"

      fill_in "Title", with: "Test Title"
      
      click_on "Bold"
      
      fill_in_trix_editor 'post_rich_content_trix_input_post', with: "Test Content"
      
      fill_in "post[publish_date]", with: "09142022"
      
      click_on "Create Post"

      assert_current_path posts_path

      click_on "Test Content"

      assert_selector "h1", text: "Test Title"

      assert_selector "strong", text: "Test Content"
    end
  end

  test "Post comments can be hidden" do
    visit post_path(posts(:two))
    
    comment_content = comments(:janes_comment).content
        
    assert_text comment_content

    click_on "Hide"

    assert_no_text comment_content 

    click_on "Show"

    assert_text comment_content 
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
    login_as users(:john)
    
    visit posts_path
    
    post = Post.ordered.first
    
    assert_text post.title

    accept_confirm do      
      click_on "Delete", match: :first
    end
    
    assert_current_path posts_path
    
    assert_no_text post.title
  end

  test "editing a post" do
    login_as users(:john)

    visit posts_path
    click_on "Edit", match: :first
    
    fill_in "Title", with: "yeet"
    
    fill_in_trix_editor 'post_rich_content_trix_input_post_' + Post.ordered.first.id.to_s, with: "yote"

    click_on "Update Post"
    assert_current_path posts_path
    assert_text "yeet"

    assert_text "yote"
  end

  test "Posts paginate via turbo stream" do
    visit posts_path
    assert_selector('div.post__preview', count: 2)
    scroll_to(100, 500)
    assert_selector('div.post__preview', count: 4)
  end

  test "Featured posts are correctly ranked" do
    expected_ranking = [posts(:six).title, posts(:one).title, posts(:two).title]
    visit featured_posts_path

    page_ranking = page.all(:css, 'h2')
    page_ranking_titles = page_ranking.map {|element| element.text}

    assert_not_equal expected_ranking, page_ranking_titles.shuffle

    assert_equal expected_ranking, page_ranking_titles
  end

end
