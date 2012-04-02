require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "Create Article" do
    assert_difference "Article.count",1 do
      article = Article.new(:name=>"Test Article",:summary=>"Test Summary Article",
                  :content=>"hello! rails",:allow_comment=>false,:sort=>"123",:user_id=>1,:guide_id=>1)
      assert article.valid?
      assert article.save
      assert !article.is_top
      assert_equal Article::COMMENT_OFF,article.allow_comment
      assert_equal 0,article.browses
    end
  end

  test "Article Name is too long to create" do
    assert_difference "Article.count",0 do
      article = Article.new(:name=>"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890ssssssssssssssssssssdddddddddfffffssssssssssssddddddddxxxxxxxffffffffffffggggggg",:summary=>"Test Summary Article",:content=>"hello! rails",:sort=>"123",:user_id=>1,:guide_id=>1)

      assert !article.valid?
      assert !article.save
    end
  end

  test "Article's author method and guide_view method and review_stat method" do
    desginGuide = guides(:desgin)
    lilei = users(:lilei)

    article = Article.new(:name=>"Test Article",:summary=>"Test Summary Article",
                  :content=>"hello! rails",:allow_comment=>false,:sort=>"123",:user_id=>lilei.id,:guide_id=>desginGuide.id)    
    
    assert_equal article.guide_view,desginGuide.name
    assert_equal article.author,  lilei.name

    study_rails = articles(:study_rails)
    content = "hello world"

    count = study_rails.review_stat

    assert_difference "Comment.count",1 do
      study_rails.add_comments({:content=>content,:address=>"192.168.0.1", :user_id=>lilei.id ,:is_show=>Comment::SHOW_ON},lilei)
    end
    assert_equal study_rails.review_stat,(count + 1)
  end

  test "toggle is pass(default is true)" do
    article = articles(:study_rails)
    article.toggle_is_pass
    assert !article.is_pass
    article.toggle_is_pass
    assert article.is_pass 
  end

  test "toggle allow comment(default is true)" do
    article = articles(:study_rails)
    article.toggle_allow_comment
    assert !article.allow_comment
    article.toggle_allow_comment
    assert article.allow_comment 
  end

end
