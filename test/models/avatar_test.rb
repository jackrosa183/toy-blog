require "test_helper"

class AvatarTest < ActiveSupport::TestCase
  test "Larger than 5mb cant be uploaded" do
    @user = users(:john)
    @avatar = @user.create_avatar
    # debugger
    @avatar.image.purge
    @avatar.image.attach(io: File.open('test/fixtures/files/big_photo.jpeg'), filename: 'big_photo.jpeg')
    # @avatar.save
    assert_equal @avatar.errors.count, 1

    @avatar.image.purge
    @avatar.image.attach(io: File.open('test/fixtures/files/blank_avatar.jpeg'), filename: 'blank_avatar.jpeg')
    assert_equal @avatar.errors.count, 0
  end
end
