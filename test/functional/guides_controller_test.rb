require 'test_helper'

class GuidesControllerTest < ActionController::TestCase
   
  test "guide edit method" do
    lilei, guide = users(:lilei), guides(:index)
    session[:current_user_id] = lilei.id
    get :edit,:id=>1
    assert_response 200
    
    #total = Guide.count
    name = "guides test 12"
    assert_difference "Guide.count",0 do
      put :update, {:id=>guide.id,:guide=>{:name=>name,:user_id=>lilei.id,:uri=>"index",:sequence=>2,:parent_id=>-1}}
    end  

    guide.reload
    assert_equal name, guide.name
    assert_equal guide.user, lilei
    assert_equal lilei.guides.include?(guide), true

  end
  
  test "Guide new,create method and show" do
    session[:current_user_id] = users(:lilei).id
    get :new
    assert_response 200

    assert_difference "Guide.count",1 do
      post :create,:guide=>{:name=>"guides test",:uri=>"index",:show=>1,:way=>"1",:sequence=>2,:parent_id=>-1}
      assert_response 302
      assert_redirected_to root_path
    end

    guide = Guide.last
    get :show,:id=>guide
    assert_response 200
    assert_equal guide,assigns(:guide)
  end

  test "destroy guide method" do
    session[:current_user_id] = users(:lilei).id
    assert_difference "Guide.count",-1 do
      delete :destroy, :id=>1
      assert_response 302
    end
  end

end
