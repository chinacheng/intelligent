# encoding: utf-8

require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  test 'user topic' do
    lilei = users('lilei')
    topic = nil;
    assert_difference ['Topic.count', 'lilei.topics.count'], 1 do
      topic = Topic.create(:name => 'topic', :user_id => lilei.id, :description => 'this is a topic of lilei')
    end
    assert lilei.topics.include?(topic)
    assert_equal topic.user, lilei
    assert_equal topic.name, 'topic'
  end

  test 'topic with blank name' do
    assert_no_difference 'Topic.count' do
      topic = Topic.new(:name => ' ', :user_id => users('lilei').id)
      assert !topic.valid?
    end
  end

  test 'topic without a create user' do
    assert_no_difference 'Topic.count' do
      topic = Topic.new(:name => 'topic', :user_id => '')
      assert !topic.valid?
    end
  end
end
