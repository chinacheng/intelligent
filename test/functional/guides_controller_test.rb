require 'test_helper'

class GuidesControllerTest < ActionController::TestCase
   
  test "guide edit method" do
  #  guide = guides(:index)
  #  assert_equal true,guide.save
    get :edit,:id=>1
    assert_response 200
    
    #total = Guide.count
    assert_difference "Guide.count",0 do
      put :update, {:id=>1,:guide=>{:name=>"guides test 12",:show=>1,:way=>"way",:sequence=>2,:parent_id=>-1}}
    end  

    guide = Guide.find_by_id(1)
    assert_equal "guides test 12",guide.name
  end
  
  test "Guide new,create method and show" do
    get :new
    assert_response 200

    assert_difference "Guide.count",1 do
      post :create,:guide=>{:name=>"guides test",:show=>1,:way=>"1",:sequence=>2,:parent_id=>-1}
      assert_response 302
      assert_redirected_to root_path
    end

    guide = Guide.last
    get :show,:id=>guide
    assert_response 200
    assert_equal guide,assigns(:guide)
  end

  # 
  test "destroy guide method" do
    assert_difference "Guide.count",-1 do
      delete :destroy, :id=>1
      assert_response 302
    end
  end
end
