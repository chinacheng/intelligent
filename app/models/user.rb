require "digest"
require "uuidtools"

class User < ActiveRecord::Base

  validates_presence_of :email, :login, :salt
  validates_presence_of :gender
  validates_presence_of :password, :on=>:create
  validates_presence_of :password_confirmation, :on=>:create
  validates_confirmation_of :password
  validates_length_of :password,:within=>4..60, :on=>:create
  validates_uniqueness_of :login,:email
  validates_length_of :login,:within=>2..60
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  attr_protected :id,:salt
  attr_accessor :password,:password_confirmation

  GENDER_MALE = "male"
  GENDER_FEMALE = "female"

  include Relative::UserMethods
  include Guide::UserMethods
  include UserRole::UserMethods

  has_attached_file :avatar,:styles => {:medium=>"300*300>",:thumb=>"100*100>",:tiny=>"25*25>"}

  def self.login(email,password)
    user = User.find_by_email(email)
    return false if user.blank?
    if user.hashed_password == User.encrypt(password,user.salt)
      return user 
    end
    return false
  end

  def gender_text
    case gender
    when GENDER_MALE  then I18n.t("model.user.gender_male") 
    when GENDER_FEMALE then I18n.t("model.user.gender_female")
    end
  end

  def password=(pass)
    @password = pass
    self.salt = User.random_string(10) if !self.salt?
    self.hashed_password = User.encrypt(@password, self.salt)
  end

  # add role to user
  def add_role(role_str)
    role = Role.find_by_name(role_str)
    UserRole.create(:user => self, :role => role)
  end

  # if the user has avatar return true, or, return false
  def has_avatar?
    !self.avatar_file_name.blank?
  end

  protected

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def self.random_string(len)
    #generat a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

end
