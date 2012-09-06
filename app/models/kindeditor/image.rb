# encoding: utf-8

class Kindeditor::Image < Kindeditor::Asset
  mount_uploader :asset, Kindeditor::ImageUploader
end
