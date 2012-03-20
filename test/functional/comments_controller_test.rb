# encoding: utf-8

require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  test "the user commit comments" do
    lilei, study_rails  = users(:lilei), articles(:study_rails)
    lilei_comment =  comments(:lilei_comment_study_rails)

    session[:current_user_id] = lilei.id

    assert_difference "Comment.count",1 do
      post :create,:article_id=>study_rails.id,:comment=>{:content=>"good, very useful",:address=>"0.0.0.0"}
    end
    assert_redirected_to article_path(:id=>study_rails.id)
    comment = Comment.last
    assert_equal true, study_rails.comments.include?(comment)
    assert_equal study_rails, comment.host
    assert_equal lilei, comment.user
    assert_equal comment.content, "good, very useful"
    assert_equal comment.address, "0.0.0.0"

    # content can not be blank
    assert_no_difference "Comment.count" do
      post :create,:article_id=>study_rails.id,:comment=>{:content=>"",:address=>"192,168.0.1"}
    end

    # destroy the comment
    assert_difference "Comment.count", -1 do
      delete :destroy,:id=>comment.id
    end

  end

  test "delete other's comment is forbidden" do
    comment =  comments(:lilei_comment_study_rails)
     # create a comment and test the function that other people should not delete lilei's comment 
    session[:current_user_id] = users(:lucy).id
    # destroy the comment
    assert_no_difference "Comment.count" do
      delete :destroy,:id=>comment.id
      assert_response 404
    end
  end

end
