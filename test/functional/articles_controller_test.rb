require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

  #
  test "test new and create method" do
    get :new
    assert_response 200

    assert_difference "Article.count",1 do
      post :create,:article=>{:name=>"guides test",:show=>1,:way=>"1",:sequence=>2,:parent_id=>-1}
      assert_response 302
      assert_redirected_to article_index_path
    end
  end

  #
  test "test edit and update method" do
    get :edit,:id=>1
    assert_response 200

    assert_difference "Article.count",0 do
      put :update, {:id=>1,:article=>{:name=>"guides test 12",:show=>1,:way=>"way",:sequence=>2,:parent_id=>-1}}
    end

    article = Article.find_by_id(1)
    assert_equal "guides test 12",article.name
  end

  #
  test "test destroy method" do
    assert_difference "Article.count",-1 do
      delete :destroy, :id=>1
      assert_response 302
    end
  end
end
