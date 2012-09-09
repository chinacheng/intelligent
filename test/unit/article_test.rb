# encoding: utf-8

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'Create Article Successed, the count of author articles is increase' do
    lilei = users('lilei')
    assert_difference ['Article.count', 'lilei.articles.count'],1 do
      article = Article.new(:name => 'Test Article',
                            :summary => 'Test Summary Article',
                            :content => 'hello! rails',
                            :allow_comment => false,
                            :sort => '123',
                            :user_id => lilei.id,
                            :guide_id => 1)
      assert article.valid?
      assert article.save
      assert !article.is_top
      assert_equal article.title, article.name
      # the author is the alias for uer
      assert_equal article.author, article.user
      assert_equal article.title, 'Test Article'
      assert_equal Article::COMMENT_OFF,article.allow_comment
      assert_equal 0,article.browses
    end
  end

  test 'Article Name is too long to create' do
    assert_difference 'Article.count',0 do
      article = Article.new(:name => 'a long title'*200,
                            :summary => 'Test Summary Article',
                            :content => 'hello! rails',
                            :sort => '123',
                            :user_id => 1,
                            :guide_id => 1)
      assert !article.valid?
      assert !article.save
    end
  end

  test "Article's author method and guide_view method and review_stat method" do
    desgin_guide = guides(:desgin)
    lilei = users(:lilei)

    article = Article.new(:name => 'Test Article',
                          :summary => 'Test Summary Article',
                          :content => 'hello! rails',
                          :allow_comment => false,
                          :sort => '123',
                          :user_id => lilei.id,
                          :guide_id => desgin_guide.id)    

    assert_equal article.guide, desgin_guide
    assert_equal article.author, lilei

    study_rails = articles(:study_rails)
    content = 'hello world'

    count = study_rails.comments.size

    assert_difference 'Comment.count',1 do
      study_rails.add_comments({:content => content,
                               :address => '192.168.0.1', 
                               :user_id => lilei.id,
                               :is_show => Comment::SHOW_ON},lilei)
    end
    assert_equal study_rails.comments_count,(count + 1)
  end

  test 'toggle is pass(default is true)' do
    article = articles(:study_rails)
    not_passed_count = Article.not_passed.size
    passed_count = Article.passed.size

    # change to not pass
    assert_difference("Article.passed.count", -1) do
      assert_difference("Article.not_passed.count", 1) do
        article.toggle_is_pass
        assert !article.is_pass
        # the count of not passed artiles is add 1, on the other hand, the count of passed articles is minus 1
        assert_equal not_passed_count + 1, Article.not_passed.size
        assert_equal passed_count - 1, Article.passed.size
      end
    end

    # change to pass
    assert_difference("Article.passed.count", 1) do
      assert_difference("Article.not_passed.count", -1) do
        article.toggle_is_pass
        assert article.is_pass 
        assert_equal not_passed_count, Article.not_passed.size
        assert_equal passed_count, Article.passed.size
      end
    end
  end

  test 'toggle allow comment(default is true)' do
    article = articles(:study_rails)
    article.toggle_allow_comment
    assert !article.allow_comment
    article.toggle_allow_comment
    assert article.allow_comment 
  end

end
