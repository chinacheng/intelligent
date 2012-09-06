# encoding: utf-8

class MediaItem < ActiveRecord::Base

  belongs_to :media
  has_many  :media_comments

end
