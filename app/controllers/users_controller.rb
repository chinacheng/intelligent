# encoding: utf-8

class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "注册成功"
      return redirect_to session_new_path 
    end
      flash[:error] = @user.errors
    return render :action=>:new
  end

end
