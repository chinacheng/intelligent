# encoding: utf-8

require 'test_helper'

class RoleTest < ActiveSupport::TestCase

  test "create_role_success_test" do
    assert_difference "Role.count",1 do
      role = Role.new(:name => "123456")
      assert role.valid?
      assert role.save

      # name is an uniqueness attribute, so try to create a role with the same name will fail 
      role_next = Role.new(:name => "123456")
      assert !role_next.valid?
      assert !role_next.save

      # name is also a presences attr
      role_third = Role.new(:name => "")
      assert !role_third.valid?
      assert !role_third.save
    end
  end

end
