class Role < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :remark,:within=>0..255

  ROLE_ADMIN = "admin"
  ROLE_COMPANY = "company"
  ROLE_ENGINEER = "engineer"
  ROLE_NORMAL = "normal"

  def role_str
    case name
    when ROLE_ADMIN then "管理员"
    when ROLE_COMPANY then "公司"
    when ROLE_ENGINEER then "工程师"
    when ROLE_NORMAL then "注册会员" 
    end
  end

end
