require 'test_helper'

class Admin::StartSuperControllerTest < ActionController::TestCase

  test "admin_start_super" do
    get :new
    assert_equal true, current_user.blank?
    assert_response 200
    post 'create',:email => "admin@test.com",:password => "123456"
    assert_response 302
    assert_redirected_to admin_index_path  
    admin = User.find_by_email("admin@test.com")

    assert admin.email,current_user.email
    assert admin.login,current_user.login
    assert_equal admin,current_user
  end

  test "normal user is forbidden" do
    post "create",:email => "lilei@test.com", :password => "123456"
    assert_response 302
    assert_redirected_to root_path
  end

end
