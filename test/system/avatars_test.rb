require "application_system_test_case"

class AvatarsTest < ApplicationSystemTestCase
  setup do
    login_as users(:john)
  end

  test "User gets redirected when uploading too large of an image" do
    visit new_avatar_path
    attach_file "avatar_image", file_fixture("big_photo.jpeg")
    click_on "Create Avatar"

    assert_text "5 MB"
  end

  test "user can add appropriately sized image" do
    login_as users(:jane)

    visit new_avatar_path
    attach_file "avatar_image", file_fixture("blank_avatar.jpeg")
    click_on "Create Avatar"

    assert_no_text "5 MB" 
    assert_no_text "Warning"
  end
end