class AdminController < ApplicationController

  layout "admin"
  
  before_filter :check_admin
  def check_admin
    if !current_user.is_admin?
      render :status=>403, :text=>"you are in the wrong place"
    end
  end

  def index
  end

end
