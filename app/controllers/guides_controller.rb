class GuidesController < ApplicationController

  before_filter :per_load
  def per_load
    @guide = Guide.find_by_id(params[:id]) if params[:id] 
  end

  def new
    @guide = Guide.new
  end

  def create 
    @guide = Guide.new(params[:guide])

    if @guide.save
      flash[:notice] = I18n.t("controller.guides.save_success")
      return redirect_to root_path
    end
    flash[:error] = I18n.t("controller.guides.save_fail")
    return render :action=>:new 
  end

  def edit
  end

  def update
    if @guide.update_attributes(params[:guide])
      flash[:notice] = I18n.t("controller.guides.update_success")
      return redirect_to root_path
    end
    flash[:error] = I18n.t("controller.guides.update_fail")
    return redirect_to guides_update_path
  end

  def destroy 
    if @guide.destroy
      flash[:notice] = I18n.t("controller.guides.remvoe_success")
      redirect_to root_path
    end
  end
  
end
