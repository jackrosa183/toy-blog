require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    login_as users(:admin)
  end

  test "only admin can see users button" do
    login_as users(:john)
    visit posts_path
    assert_no_text "Users"

    login_as users(:admin)
    visit posts_path
    assert_text "Users"
  end

  test "only admin can create users" do
    visit users_path
    click_on "Create New User"

    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password"
    click_on "Create User"

    assert_selector "p", text: "newuser@example.com"
  end

  test "regular user redirect after cannot access users" do 
    login_as users(:john)
    visit users_path

    assert_current_path posts_path
  end

  test "admin can search users" do
    login_as users(:admin)
    visit users_path
    fill_in "Search Users", with: "john"
    click_on "Search"

    assert_selector "p", text: "johndoe@example.com"
  end

end