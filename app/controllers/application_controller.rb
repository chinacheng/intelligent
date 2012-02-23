class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  before_filter :load_guides
  def load_guides
    @guides = Guide.list_display
  end
end
