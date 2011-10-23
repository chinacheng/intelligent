require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  test "create_role_success_test" do
    assert_difference "User.count",1 do
      role = Role.new(:name=>"testRole")

      assert_equal true,role.valid?
      assert_equal true,role.save

    end
  end
end
