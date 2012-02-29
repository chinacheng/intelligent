# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper

  before_filter :load_guides
  def load_guides
    @guides = Guide.list_display
  end

  before_filter :login_require
  def login_require
    if current_user.blank?
      return redirect_to :controller=>:session, :action=>:new
    end
  end

end
