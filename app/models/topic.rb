# encoding: utf-8

class Topic < ActiveRecord::Base

  validates_presence_of :name, :user_id
  belongs_to :user

  include Picture::HostMethods

end
