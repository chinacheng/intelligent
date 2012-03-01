require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  
  test "user_login" do
    get :new
    assert_equal true, current_user.blank?
    assert_response 200
    post 'create',:email => "lilei@test.com",:password => "123456"
    assert_response 302
    assert_redirected_to root_path  
    lilei = User.find_by_email("lilei@test.com")

    assert lilei.email,current_user.email
    assert lilei.login,current_user.login
    assert_equal lilei,current_user
  end

  test "admin login" do
    post 'create',:email => "admin@test.com",:password => "123456"
    assert_response 302
    assert_redirected_to admin_index_path  
  end

end
