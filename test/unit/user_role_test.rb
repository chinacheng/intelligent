# encoding: utf-8

require 'test_helper'

class UserRoleTest < ActiveSupport::TestCase

  test 'user_role_relate_test' do
    lucy = users('lucy')
    assert_difference 'UserRole.count',1 do
      role_admin = roles('admin')
      lucy.add_role(Role::ROLE_ADMIN)
      user_role = UserRole.last
      assert_equal user_role.user.name, lucy.name
      assert_equal user_role.role.name, role_admin.name
      assert_equal lucy.role.name, role_admin.name
    end
    assert_equal true,lucy.is_admin?
    assert_difference 'UserRole.count',0 do
      lucy.add_role(Role::ROLE_ADMIN)
    end
  end

end
