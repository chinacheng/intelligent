# encoding: utf-8

class IndexController < ApplicationController

  skip_before_filter :login_require

  def index
    @guides = Guide.list_display
    @articles = Article.order('created_at desc').limit(10)
    @pictures = TopPicture.tops
  end

end
