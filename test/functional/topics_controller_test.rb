# encoding: utf-8

require 'test_helper'

class TopicsControllerTest < ActionController::TestCase

  def login_require
    yield
    assert_response 302
    assert_redirected_to session_new_path
  end

  test "new create edit update is need login" do
    login_require{get :new}
    login_require{post :create, :topic => {:name => "topic"}}

    topic_id = topics("lilei_study_rails").id
    login_require{get :edit, :id => topic_id}
    login_require{put :update, :id => topic_id}
  end

  test "show is not need login" do
    topic_id = topics("lilei_study_rails").id
    get :show, :id => topic_id
    assert_response 200
    
    # index is show user's topics
    user_login("lilei")
    get :index
    assert_response 200
  end

  test "lilei create a new topic" do
    user_login("lilei")
    lilei = users("lilei")
    get :new 
    assert_response 200
    topic = nil
    assert_difference "Topic.count", 1 do 
      post :create, :topic => {:name => "study rails", :description => "study rails"}
      topic = Topic.last
      assert_redirected_to :action => :show, :id => topic.id
    end
    assert lilei.topics.include?(topic)
    assert_equal topic.user, lilei
  end

  test "lilei update his rails topic" do
    user_login("lilei")
    topic = topics("lilei_study_rails")
    get :edit, :id => topic.id
    assert_response 200
    assert_no_difference "Topic.count" do
      put :update, :id => topic.id, :topic => {:name => "hello, world", :description => "world hello"}
    end
    topic.reload
    assert_equal [topic.name, topic.description], ["hello, world", "world hello"]
  end

  test "lilei destrou his topic" do
    user_login("lilei")
    topic = topics("lilei_study_rails")
    assert_difference "Topic.count", -1 do
      delete :destroy, :id => topic.id
    end
  end

  test "admin destroy his topic" do
    admin_login
    topic = topics("lilei_study_rails")
    assert_difference "Topic.count", -1 do
      delete :destroy, :id => topic.id
    end
  end

  test "other people is not allow lilei's topic" do
    user_login("lucy")
    topic = topics("lilei_study_rails")
    assert_no_difference "Topic.count" do
      delete :destroy, :id => topic.id
      assert_response 403
    end
  end
end
