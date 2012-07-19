# encoding: utf-8

class ApplicationController < ActionController::Base
  # reset captcha code after each request for security
  after_filter :reset_last_captcha_code!


  protect_from_forgery
  include ApplicationHelper

  before_filter :load_guides
  before_filter :login_require

  # in the production evn, rails do itself

  #if Rails.env.production?
  #  rescue_from ActionController::RoutingError, :with => :render_404
  #  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  #end

  #protected
  # Rails has this functionality built in already. If you want to show a 404 page, create a render_404 method (or "not_found" as I called it) in ApplicationController 
  #def render_404
  #  render :text => "404 , this page you found is not existed", :status => 404
  #end

  private

  def login_require
    if current_user.blank?
      return redirect_to :controller=>:session, :action=>:new
    end
  end

  def load_guides
    @guides = Guide.list_display
  end

end
