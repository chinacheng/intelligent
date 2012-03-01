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
      assert_redirected_to session_new_path
    end
  end

  test "user_avatar_upload" do
    lilei = users("lilei")
    avatar_file = File.new("#{RAILS_ROOT}/test/tmp/avatar_test.jpeg")  
    get :avatar_new,:id=>lilei.id
    assert_response 200
    put :avatar_create,:id=>lilei.id,:user=>{:avatar=>avatar_file}
    assert_response 302
    #TODO this is a problem , test user upload atatar
    #lilei.reload
    #assert_equal lilei.has_avatar?,true
  end

  test "index action" do
    get :index
    assert_response 200
    assert_not_nil assigns(:users)
  end

  test "test user's fans and follows" do
    lilei, lucy, kate = users("lilei"),users("lucy"),users("kate")
    assert_difference "Relative.count",3 do
      lilei.fan(lucy)
      lilei.fan(kate)
      lucy.fan(lilei)
    end
    session[:user_id] = kate.id
    get :fans,:id=>lilei.id
    assert_response 200
    fans = assigns(:fans)
    assert_equal fans.size,1
    assert_equal true,fans.include?(lucy)

    get :follows,:id=>lilei.id
    assert_response 200
    follows = assigns(:follows)
    assert_equal follows.size,2
    assert_equal true,follows.include?(lucy)
    assert_equal true,follows.include?(kate)
  end

end
