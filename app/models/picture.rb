class Picture < ActiveRecord::Base

  validates_presence_of :user_id, :photo_file_name
  belongs_to :user
  belongs_to :host, :polymorphic => true

  has_attached_file :photo

  module UserMethods
    def self.included(base)
      base.has_many :pictures
    end
  end

  module HostMethods
    def self.included(base)
      base.has_many :pictures, :as => :host
    end

    def add_picture(user, file)
      Picture.create(:user => user, :host => self, :photo => file)
    end
  end

end
