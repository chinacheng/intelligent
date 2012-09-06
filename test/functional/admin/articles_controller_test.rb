# encoding: utf-8

require 'test_helper'

class Admin::ArticlesControllerTest < ActionController::TestCase

  def admin_login_get_article
    admin_login
    @article = articles(:study_rails)
  end

  test "common user can not access this controller and it's actions" do
    session[:current_user_id] = users(:lilei).id
    article = articles(:study_rails)
    get :index
    assert_response 403
    get :show,:id => article.id
    assert_response 403
    get :edit,:id => article.id
    assert_response 403
  end
  
  test "admin user can access the controller and it's actions " do
    admin_login_get_article
    get :index
    assert_response 200 
    get :show,:id => @article.id
    assert_response 200
    get :edit,:id => @article.id
    assert_response 200
  end

  test "toggle article's is_pass status(default is true)" do
    admin_login_get_article
    put :toggle_is_pass, :id=>@article.id
    @article.reload
    assert_equal @article.is_pass, false
    put :toggle_is_pass, :id=>@article.id
    @article.reload
    assert @article.is_pass  
  end

  test "toggle article's allow_comment status(default is true)" do 
    admin_login_get_article
    put :toggle_allow_comment, :id=>@article.id
    @article.reload
    assert !@article.allow_comment
    put :toggle_allow_comment, :id=>@article.id
    @article.reload
    assert @article.allow_comment
  end

end
