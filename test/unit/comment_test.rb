# encoding: utf-8

require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "add comments to a article" do
    study_rails,lilei = articles(:study_rails), users(:lilei)
    content = "hello world"
    lilei_comments_size = lilei.comments.size
    study_comments_size = study_rails.comments.size
    assert_difference "Comment.count",1 do
      study_rails.add_comments({:content=>content,:address=>"192.168.0.1", :user_id=>lilei.id ,:is_show=>Comment::SHOW_ON},lilei)
    end

    comment = Comment.last
    assert_equal comment.content, content
    assert_equal comment.user, lilei

    assert lilei.comments.include?(comment)
    assert_equal lilei.comments.size - lilei_comments_size, 1

    assert_equal comment.host, study_rails
    assert study_rails.comments.include?(comment)
    assert_equal study_rails.comments.size - study_comments_size, 1
  end

  test "host's name and host's type" do
    study_rails,lilei = articles(:study_rails), users(:lilei)
    content = "hello world"
    lilei_comments_size = lilei.comments.size
    study_comments_size = study_rails.comments.size
    assert_difference "Comment.count",1 do
      study_rails.add_comments({:content=>content,:address=>"192.168.0.1", :user_id=>lilei.id ,:is_show=>Comment::SHOW_ON},lilei)
    end

    comment = Comment.last
    assert_equal comment.host_name_view, study_rails.name

    assert_equal comment.host_type, Comment::HOST_TYPE_ARTICLE
  end

  test "toggle allow show(default is true)" do
    #comment = comments(:hanmm)
    lilei = users(:lilei)
    comment = Comment.new(:content=>"sasdfg",:address=>"192.168.1.15",
            :host_id=>"1",:host_type=>"Article")

    assert_difference "Comment.count",1 do
      assert comment.valid?
      assert comment.save
    end
    
    assert_equal comment.is_show, Comment::SHOW_ON

    comment.toggle_allow_show
    assert_equal comment.is_show, Comment::SHOW_OFF
    comment.toggle_allow_show
    assert_equal comment.is_show, Comment::SHOW_ON
  end

  test "comment's author" do
    lilei = users(:lilei)
    comment = Comment.new(:content=>"123456sagah",:address=>"127.0.0.1",
                :host_id=>"1",:host_type=>"Article",:user_id=>lilei.id)

    assert_equal lilei.name,comment.author
  end

  test "comment's anonymous" do
    comment = Comment.new(:content=>"123456sagah",:address=>"127.0.0.1",
                :host_id=>"1",:host_type=>"Article")
    
    assert_equal comment.author,I18n.t("view.comments.anonymous")
  end

end

