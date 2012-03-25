class Topic < ActiveRecord::Base

  validates_presence_of :name, :user_id
  belongs_to :user

end
