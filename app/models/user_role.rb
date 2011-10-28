class UserRole < ActiveRecord::Base
  
  validates_presence_of :user_id,:role_id
  validates_uniqueness_of :user_id,:scope=>:role_id,:message=>"每个用户只能分配一个权限！"

  belongs_to :user
  belongs_to :role
end
