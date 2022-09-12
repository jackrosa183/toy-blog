require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    login_as users(:admin)
  end

  test "only admin can see users" do
    login_as users(:john)
    visit posts_path
    assert_no_text "Users"

    login_as users(:admin)
    visit posts_path
    assert_text "Users"
  end
end