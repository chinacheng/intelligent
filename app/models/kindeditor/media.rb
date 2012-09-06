# encoding: utf-8

class Kindeditor::Media < Kindeditor::Asset
  mount_uploader :asset, Kindeditor::MediaUploader
end
