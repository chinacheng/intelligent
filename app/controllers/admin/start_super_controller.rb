# encoding: utf-8

class Admin::StartSuperController < AdminController
  skip_before_filter :login_require

  def new
    render :layout=>false
  end

  def create
    if simple_captcha_valid?
      if user = User.login(params[:email],params[:password])
        session[:current_user_id] = user.id
        return _redirect_by_role
      end
    end
    flash[:error] = I18n.t("view.login.error") 
    return render :action => :new, :layout => false
  end

  def destroy
    @_session_user = session[:current_user_id] = nil
    redirect_to root_path 
  end

  private
  def _redirect_by_role
    case true
    # admin is not allow login from this action
    when current_user.is_admin? then redirect_to admin_index_path
    else destroy
    end
  end

end
