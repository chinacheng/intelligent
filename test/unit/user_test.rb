require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # successed create a user model 
  test "create_user_success_test" do
    assert_difference "User.count",1 do 
      user = User.new(:name=>"test_name",:login=>"test_login",:email=>"user@test.com",
                      :password=>"123456",:password_confirmation=>"123456",:gender=>User::GENDER_MALE)

      assert user.valid?
      assert user.save
      assert_equal user.hashed_password,User.encrypt("123456", user.salt)
      assert_equal user.name, "test_name"
      assert_equal user.login, "test_login"
      assert_equal user.email, "user@test.com"
      assert_equal user.gender, User::GENDER_MALE

      assert !User.login("user@test.com","12")
      assert !User.login("sss","333")
      assert !!User.login("user@test.com","123456")
    end
  end

  # too short login
  test "create_user_with_a_short_login_can_not_success" do
    assert_no_difference "User.count" do 
      user = User.new(:name=>"t",:login=>"t",:email=>"user@test.com",
                      :password=>"123456",:password_confirmation=>"123456",:gender=>User::GENDER_MALE)
      assert !user.valid?
      assert !user.save
    end
  end
  
  # no login
  test "create_user_without_login_can_not_success" do
    assert_no_difference "User.count" do 
      user = User.new(:name=>"test",:login=>"",:email=>"user@test.com",
                      :password=>"123456",:password_confirmation=>"123456",:gender=>User::GENDER_MALE)
      assert !user.valid?
      assert !user.save
    end
  end

  # no password
  test "create_user_without_password_can_not_success" do
    assert_no_difference "User.count" do 
      user = User.new(:name=>"test",:login=>"test_user",:email=>"user@test.com",
                      :password=>"",:password_confirmation=>"123456",:gender=>User::GENDER_MALE)
      assert !user.valid?
      assert !user.save
    end
  end

  # no email
  test "create_user_without_email_can_not_success"  do
    assert_no_difference "User.count" do 
      user = User.new(:name=>"test",:login=>"user_test",:email=>"",
                      :password=>"123456",:password_confirmation=>"123456",:gender=>User::GENDER_MALE)
      assert !user.valid?
      assert !user.save
    end
  end

  # too short password
  test "create_user_with_short_email_success" do 
    assert_no_difference "User.count" do 
      user = User.new(:name=>"test",:login=>"user_test",:email=>"user@test.com",
                      :password=>"123",:password_confirmation=>"123456",:gender=>User::GENDER_MALE)
      assert !user.valid?
      assert !user.save
    end
  end

  # error email
  test "create_user_with_a_error_format_email_not_success" do
    assert_no_difference "User.count" do 
      user = User.new(:name=>"test",:login=>"user_test",:email=>"usertest.com",
                      :password=>"123456",:password_confirmation=>"123456",:gender=>User::GENDER_MALE)
      assert !user.valid?
      assert !user.save

      user = User.new(:name=>"test",:login=>"user_test",:email=>"usertesti@.com",
                      :password=>"123456",:password_confirmation=>"123456",:gender=>User::GENDER_MALE)
      assert !user.valid?
      assert !user.save

      user = User.new(:name=>"test",:login=>"user_test",:email=>"user@testcom",
                      :password=>"123456",:password_confirmation=>"123456",:gender=>User::GENDER_MALE)
      assert !user.valid?
      assert !user.save
    end
  end

  # read users from fixtures, and test their password
  test "test_user_passwords" do
    lucy,lilei,kate = users("lucy"),users("lilei"),users("kate")
    assert !!User.login("lucy@test.com","123456")
    assert !!User.login("lilei@test.com","123456")
    assert !!User.login("kate@test.com","123456")
  end

end
