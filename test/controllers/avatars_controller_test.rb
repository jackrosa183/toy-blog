require "test_helper"

class AvatarsControllerTest < ActionDispatch::IntegrationTest
  test "Larger than 5mb cant be uploaded" do
    @user = users(:john)
    @avatar = @user.create_avatar
    # debugger
    @avatar.image.purge
    @avatar.image.attach(fixture_file_upload("big_photo.jpeg", "image/jpeg"))
    @avatar.save
    debugger
    assert_not @user.avatar.image.attached?


    @avatar.image.attach(fixture_file_upload("blank_avatar.jpeg", "image/jpeg"))
    assert @user.avatar.image.attached?
  end
end
