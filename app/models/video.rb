class Video < ActiveRecord::Base

  validates_presence_of :user_id

  belongs_to :user

  module UserMethods
    def self.included(base)
      base.has_many :videos
    end
  end

end
