class User < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :gender
  validates_presence_of :password
  validates_presence_of :login
  validates_presence_of :salt
  validates_uniqueness_of :login
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  GENDER_MALE = "male"
  GENDER_FEMALE = "female"

  before_create :set_salt
  def set_sale
  end

  def set_password
  end
  
end
