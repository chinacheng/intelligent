# encoding: utf-8

class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "注册成功"
      return redirect_to new_session_path 
    end
    return render :action=>:new
  end

end
