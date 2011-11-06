# encoding: utf-8

require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "user_regin_success" do
    # regin
    get :new
    assert_response 200
    # regin success
    assert_difference "User.count",1 do 
      post :create,:user=>{:name=>"user_test",:login=>"test_user",:password=>"123456",:password_confirmation=>"123456",:email=>"user@test.com",:gender=>User::GENDER_MALE}
      assert_response 302
      assert_redirected_to new_session_path
    end
  end

end
