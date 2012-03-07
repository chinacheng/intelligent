class Picture < ActiveRecord::Base

  validates_presence_of :user_id, :photo_file_name
  belongs_to :user

  module UserMethods
    def self.included(base)
      base.has_many :pictures
    end
  end

end
