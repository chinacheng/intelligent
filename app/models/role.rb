class Role < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name,:within=>6..32
  validates_length_of :remark,:within=>0..255
end
