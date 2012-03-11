class UserRole < ActiveRecord::Base
  
  validates_presence_of :user_id,:role_id
  validates_uniqueness_of :user_id,:scope=>:role_id,:message=>I18n.t("model.user_role.uniq")

  belongs_to :user
  belongs_to :role

  module UserMethods
    def self.included(base)
      base.has_one :user_role
      base.has_one :role, :through=>:user_role, :as=>:user
    end

    def is_admin?
      return false if self.role.blank?
      self.role.name == Role::ROLE_ADMIN
    end
  end

  module RoleMethods
    def self.included(base)
    end
  end

end
