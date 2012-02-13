require 'test_helper'

class RelativeTest < ActiveSupport::TestCase

  test "user follow other people" do 
    lilei, lucy, kate = users("lilei"),users("lucy"),users("kate")
    assert_difference "Relative.count",3 do 
      lilei.fan(lucy)
      kate.fan(lucy)
      kate.fan(lilei)
    end
    assert_difference "Relative.count",0 do 
      kate.fan(lilei)
    end
    assert_equal lucy.fans.size, 2
    assert_equal lucy.fans.include?(lilei), true
    assert_equal lucy.fans.include?(kate), true
    assert_equal kate.follows.size, 2

    assert_equal kate.follows.include?(lucy), true
    assert_equal kate.follows.include?(lilei), true

    assert_equal lilei.fan?(lucy),true
  end

end
