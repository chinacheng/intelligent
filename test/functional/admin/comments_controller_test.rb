# encoding: utf-8

require 'test_helper'

class Admin::CommentsControllerTest < ActionController::TestCase
  def admin_login_get_comment
    admin_login
    @comment = comments(:hanmm)
  end

  test "common user can not access this controller and it's actions" do
    session[:current_user_id] = users(:lilei).id
    comment = comments(:hanmm)
    get :index
    assert_response 403
    get :edit
    assert_response 403
    get :edit,:id => comment.id, :host_id => comment.host_id,:host_type => comment.host_type
    assert_response 403
    get :destroy
    assert_response 403
  end

  test "admin user can access the controller and it's actions " do
    admin_login_get_comment
    get :index
    assert_response 200
    get :edit, :id => @comment.id,:host_id => @comment.host_id, :host_type => @comment.host_type
    assert_response 200
    get :destroy, :id => @comment.id
    assert_response 302
  end

  test "toggle comment's is_show status(default is true)" do
    admin_login_get_comment
    get :toggle_allow_show, :id=>@comment.id,:source=>"list"
    @comment.reload
    assert_equal @comment.is_show, Comment::SHOW_OFF
    get :toggle_allow_show, :id=>@comment.id,:source=>"list"
    @comment.reload
    assert_equal @comment.is_show, Comment::SHOW_ON
  end

end
