require "digest"
require "uuidtools"

class User < ActiveRecord::Base

  validates_presence_of :name, :email, :gender, :password, :login, :salt
  validates_uniqueness_of :login
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  GENDER_MALE = "male"
  GENDER_FEMALE = "female"

  before_create :set_salt_and_password
  def set_salt_and_password
    self.salt = User.random_string(10) if !self.salt?
    self.hashed_password = User.encrypt(@password, self.salt)
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
