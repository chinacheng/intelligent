require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  
  test "user_login" do
    get :new
    assert_response 200
    post 'create',:email => "lilei@test.com",:password => "123456"
    assert_response 302
    assert_redirected_to root_path  

    assert false,current_user.blank?
  end

end
