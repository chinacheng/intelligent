class SessionController < ApplicationController

  def new
  end

  def create
    if user = User.login(params[:email],params[:password])
      session[:current_user_id] = user.id
      return redirect_to root_path
    end
    return render :action => :new
  end

  def destroy
    @_session_user = session[:current_user_id] = nil
    redirect_to root_path 
  end

end
