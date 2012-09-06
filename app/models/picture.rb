# encoding: utf-8

class Picture < ActiveRecord::Base

  validates_presence_of :user_id, :photo_file_name
  belongs_to :user
  belongs_to :host, :polymorphic => true
  has_one :top_picture

  has_attached_file :photo, :styles => {:thumb=>'x55'}

  # is set to top or not?
  def is_top?
    !top_picture.blank?  
  end

  module UserMethods
    def self.included(base)
      base.has_many :pictures
    end
  end

  module HostMethods
    def self.included(base)
      base.has_many :pictures, :as => :host
    end

    def add_picture(user, files)
      files.map do |file|
        Picture.create(:user => user, :host => self, :photo => file)
      end
    end
  end

end
