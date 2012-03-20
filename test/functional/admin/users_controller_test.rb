require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  test "admin access index action" do
    admin_login
    get :index
    assert_response 200
    assert !assigns("users").blank?
  end

  test "common user access index action" do
    user_login("lilei")
    get :index
    assert_response 403
  end

  test "admin destroy a user" do
    lilei = users("lilei")
    admin_login
    assert_difference "User.count",-1 do
      delete :destroy,:id=>lilei.id
    end
  end

  test "admin frozen a user" do
  end
  
  test "admin unfrozen a user" do
  end

end
