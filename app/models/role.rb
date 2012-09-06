# encoding: utf-8

class Role < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :remark, :within => 0..255

  ROLE_ADMIN = "admin"
  ROLE_COMPANY = "company"
  ROLE_ENGINEER = "engineer"
  ROLE_NORMAL = "normal"

  # return the name of the role
  def role_str
    case name
    when ROLE_ADMIN then I18n.t("model.role.admin") 
    when ROLE_COMPANY then I18n.t("model.role.company")
    when ROLE_ENGINEER then I18n.t("model.role.engineer")
    when ROLE_NORMAL then I18n.t("model.role.normal")
    end
  end

end
