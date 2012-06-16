# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
root = User.create(:name => 'root', :login => 'root', :email => 'root@test.com',:password=>'123456', :password_confirmation => '123456', :gender => 'male' )
root_role = Role.create(:name => 'admin', :remark => 'admin') 
root_and_role = UserRole.create(:user => root, :role => root_role)

normal = User.create(:name => 'china', :login => 'china', :email => 'china@test.com',:password=>'123456', :password_confirmation => '123456', :gender => 'male' )
