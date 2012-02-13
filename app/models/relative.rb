class Relative < ActiveRecord::Base

  validates_presence_of :fan_id, :follow_id
  validates_uniqueness_of :fan_id, :scope=>:follow_id

  belongs_to :follow, :foreign_key=>:follow_id, :class_name=>"User"
  belongs_to :fan, :foreign_key=>:fan_id, :class_name=>"User"

  module UserMethods
    def self.included(base) 
      base.has_many :relatives, :foreign_key=>:follow_id
      base.has_many :fans, :through=>:relatives, :as=>:follow

      base.has_many :follow_relatives, :foreign_key=>"fan_id",:class_name=>"Relative"
      base.has_many :follows, :through=>:follow_relatives, :as=>:fan
    end

    # a fan b, b's fans include a
    def fan(user)
      Relative.create(:fan=>self,:follow=>user)
    end

    # a is a fans of b , return true or return false
    def fan?(user)
      !!Relative.find_by_fan_id_and_follow_id(self.id,user.id)
    end

  end

end
