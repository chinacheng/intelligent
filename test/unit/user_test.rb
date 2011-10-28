require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # successed create a user model 
  test "create_user_success_test" do
    assert_difference "User.count",1 do 
      user = User.new(:name=>"test_name",:login=>"test_login",:email=>"user@test.com",
                      :password=>"123456",:password_confirmation=>"123456",:gender=>User::GENDER_MALE)

      assert_equal true,user.valid?
      assert_equal true,user.save

      assert_equal user.hashed_password,User.encrypt("123456", user.salt)
    end
  end

end
