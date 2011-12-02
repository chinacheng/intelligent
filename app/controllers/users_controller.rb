# encoding: utf-8

class UsersController < ApplicationController

  before_filter :per_load
  def per_load
    @user = User.find_by_id(params[:id]) if params[:id]
  end

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

  def avatar_new
  end

  def avatar_create
    @user.avatar = params[:user][:avatar]
    if @user.save
      return redirect_to root_path 
    end
    render :action=>:avatar_new,:id=>params[:user][:id]
  end

end
