# encoding: utf-8

class UsersController < ApplicationController

  skip_before_filter :login_require

  before_filter :per_load
  def per_load
    @user = User.find_by_id(params[:id]) if params[:id]
  end

  def index
    @users = User.paginate(:per_page => 10, :page => params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = I18n.t("controller.users.reg_success") 
      return redirect_to session_new_path 
    end
      flash[:error] = @user.errors
    return render :action => :new
  end

  # upload avatar view 
  def avatar_new
  end

  # upload avatar action
  def avatar_create
    @user.avatar = params[:user][:avatar]
    if @user.save
      return redirect_to @user 
    end
    render :action => :avatar_new, :id => params[:user][:id]
  end

  # cut user's avatar 
  def avatar_cut
    if @user.cut_avatar(params[:user])
      flash[:notice] = I18n.t("common.operate_success")
      return redirect_to @user
    end
    flash[:notice] = I18n.t("common.operate_fail")
    return redirect_to :action => :avatar_new, :id => params[:id]
  end

  def fans
    @fans = @user.fans
  end

  def follows
    @follows = @user.follows
  end

end
