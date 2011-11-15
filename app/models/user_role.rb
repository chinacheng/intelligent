class UserRole < ActiveRecord::Base
  
  validates_presence_of :user_id,:role_id
  validates_uniqueness_of :user_id,:scope=>:role_id,:message=>I18n.t("model.user_role.uniq")

  belongs_to :user
  belongs_to :role
end
