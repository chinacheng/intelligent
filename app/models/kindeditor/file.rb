# encoding: utf-8

class Kindeditor::File < Kindeditor::Asset
  mount_uploader :asset, Kindeditor::FileUploader
end
