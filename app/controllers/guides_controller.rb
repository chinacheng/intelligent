# encoding: utf-8

class GuidesController < ApplicationController

  skip_before_filter :login_require,:only=>[:index,:show]

  before_filter :per_load
  def per_load
    @guide = Guide.find_by_id(params[:id]) if params[:id] 
  end

  def index
    @guides = Guide.find(:all)
  end

  def new
    @guide = Guide.new
  end

  def create 
    @guide = Guide.new(params[:guide])
    @guide.user_id = current_user.id
    if @guide.save
      flash[:notice] = I18n.t("controller.guides.save_success")
      return redirect_to root_path
    end
    flash[:error] = I18n.t("controller.guides.save_fail")
    return render :action=>:new 
  end

  def show
  end

  def edit
  end

  def update
    if @guide.update_attributes(params[:guide])
      flash[:notice] = I18n.t("controller.guides.update_success")
      return redirect_to root_path
    end
    flash[:error] = I18n.t("controller.guides.update_fail")
    return redirect_to :action=>:edit,:id=>params[:id] 
  end

  def destroy 
    if @guide.destroy
      flash[:notice] = I18n.t("controller.guides.remvoe_success")
      redirect_to root_path
    end
  end
  
end
