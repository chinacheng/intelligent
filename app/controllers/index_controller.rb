# encoding: utf-8

class IndexController < ApplicationController

  skip_before_filter :login_require

  def index
    @guides = Guide.list_display
  end

end
