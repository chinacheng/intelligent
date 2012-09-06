# encoding: utf-8

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
    assert lucy.fans.include?(lilei)
    assert lucy.fans.include?(kate)
    assert_equal kate.follows.size, 2

    assert kate.follows.include?(lucy)
    assert kate.follows.include?(lilei)

    assert lilei.fan?(lucy)
  end

  # test the method fan_each_other
  test "fan each other and remove a fan" do
    lucy,lilei = users("lucy"),users("lilei")
    assert !lucy.fan_each_other?(lilei)
    lucy.fan(lilei)
    assert !lucy.fan_each_other?(lilei)
    lilei.fan(lucy)
    assert lucy.fan_each_other?(lilei)

    # remove a fan
    lucy.remove_fan(lilei)
    assert lucy.fan?(lilei)
    assert !lucy.fan_each_other?(lilei)
    assert !lilei.fan?(lucy)

    lilei.remove_fan(lucy)
    assert !lilei.fan?(lucy)
  end

end
