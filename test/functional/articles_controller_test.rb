require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

  test "test index method" do
    get :index
    assert_response 200
  end

  test "test new and create method" do
    lilei = users(:lilei)
    session[:current_user_id] = lilei.id
    get :new
    assert_response 200

    assert_difference "Article.count",1 do
      post :create, :article => {:name => "guides test",
                                 :summary => "sd",
                                 :content => "sd",
                                 :sort => "34",
                                 :allow_comment => true,
                                 :browses => "sd" }
      assert_response 302
      assert_redirected_to articles_path
    end
    article = Article.last
    assert_equal article.user, lilei
    assert_equal [article.name, article.summary, article.content], ["guides test", "sd", "sd"]
    assert lilei.articles.include?(article)

    get :show, :id => article.id
    assert_response 200
  end

  test "test edit and update method" do
    session[:current_user_id] = users(:lilei).id
    get :edit, :id=>1
    assert_response 200

    assert_no_difference "Article.count" do
      put :update, {:id=>1, :article => {:name => "guides test 12"}}
    end

    article = Article.find_by_id(1)
    assert_equal "guides test 12",article.name
  end

  test "test destroy method" do
    session[:current_user_id] = users(:lilei).id
    assert_difference "Article.count", -1 do
      delete :destroy, :id=>1
      assert_response 302
    end
  end
end
