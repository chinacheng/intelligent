# encoding: utf-8

class SessionController < ApplicationController

  skip_before_filter :login_require

  def new
    render :layout=>false
  end

  def create
    if user = User.login(params[:email],params[:password])
      session[:current_user_id] = user.id
      return _redirect_by_role
    end
    flash[:error] = I18n.t("view.login.error") 
    return render :action => :new
  end

  def _redirect_by_role
    case true
    when current_user.is_admin? then redirect_to admin_index_path
    else redirect_to root_path
    end

  end

  def destroy
    @_session_user = session[:current_user_id] = nil
    redirect_to root_path 
  end

end
