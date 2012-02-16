class IndexController < ApplicationController

  def index
    @guides = Guide.list_display
  end

end
