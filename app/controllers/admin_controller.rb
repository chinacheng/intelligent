class AdminController < ActionController::Base

  protect_from_forgery
  include ApplicationHelper

  before_filter :login_require
  def login_require
    if current_user.blank?
      return redirect_to root_path
    end
  end
  
  before_filter :check_admin
  def check_admin
    if current_user && !current_user.is_admin?
      render :status=>403, :text=>"you are in the wrong place"
    end
  end

  def index
  end

end
