require 'test_helper'

class MenuTest < ActiveSupport::TestCase
  test "create_role_success_test" do
    assert_difference "Menu.count",1 do
      menu = Menu.new(:name => "admins",:app_id => "admin",:sequence => 1,:tip => "test of menus",
                      :image => "images/menus/1.gif")

      assert_equal true,menu.valid?
      assert_equal true,menu.save		
    end
  end
end
