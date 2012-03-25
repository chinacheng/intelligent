require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  test "user topic" do
    lilei = users("lilei")
    topic = nil;
    assert_difference "Topic.count", 1 do
      topic = Topic.create(:name => "topic",:user_id => lilei.id, :description => "this is a lilei's topic")
    end
    assert lilei.topics.include?(topic)
    assert_equal topic.user, lilei
  end

end
