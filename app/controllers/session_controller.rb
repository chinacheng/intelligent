class SessionController < ApplicationController

  def new
  end

  def create
    if User.login(params[:email],params[:password])
      return redirect_to root_path
    end
    return render :action => :new
  end
end
