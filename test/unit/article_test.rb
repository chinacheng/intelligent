require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "Create Article" do
    assert_difference "Article.count",1 do
      article = Article.new(:name=>"Test Article",:summary=>"Test Summary Article",
                  :content=>"hello! rails",:sort=>"123",:user_id=>1,:guide_id=>1)

      assert_equal true,article.valid?
      assert_equal true,article.save
      assert_equal Article::CMMT_OFF,article.comment_tag
      assert_equal 0,article.browses
    end
  end

  test "Article too Name length" do
    assert_difference "Article.count",0 do
      article = Article.new(:name=>"1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890ssssssssssssssssssssdddddddddfffffssssssssssssddddddddxxxxxxxffffffffffffggggggg",:summary=>"Test Summary Article",:content=>"hello! rails",:sort=>"123",:user_id=>1,:guide_id=>1)

      assert_equal false,article.valid?
      assert_equal false,article.save
    end
  end

  test "Article's sort limit" do
    assert_difference "Article.count",0 do
      article = Article.new(:name=>"Test Article",:summary=>"Test Summary Article",
                  :content=>"hello! rails",:sort=>"1234567890123456789012345678901234567",:user_id=>1,:guide_id=>1)
      assert_equal false,article.valid?
      assert_equal false,article.save
    end
  end
end
