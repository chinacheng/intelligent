# encoding: utf-8

require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "add comments to a article" do
    study_rails,lilei = articles(:study_rails), users(:lilei)
    content = "hello world"
    assert_difference "Comment.count",1 do
      study_rails.add_comments({:content=>content,:address=>"192.168.0.1", :user_id=>lilei.id ,:show=>Comment::SHOW_ON})
    end

    comment = Comment.last
    assert_equal comment.content, content
    assert_equal comment.user, lilei

    assert_equal lilei.comments.include?(comment), true
    assert_equal lilei.comments.size, 1

    assert_equal comment.host, study_rails
    assert_equal study_rails.comments.include?(comment), true
    assert_equal study_rails.comments.size, 1
  end

end

