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

  test "index and show is not need login" do
    topic_id = topics("lilei_study_rails").id
    get :show, :id => topic_id
    assert_response 200
    get :index
    assert_response 200
  end

end
