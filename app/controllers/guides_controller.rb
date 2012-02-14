class GuidesController < ApplicationController
    
  def new
    @guide = Guide.new
  end

  # 
  def update
    @guide = Guide.find(params[:id])

    if @guide.update_attributes(params[:guide])
      flash[:notice] = I18n.t("controller.guides.update_success")
    else
      flash[:error] = I18n.t("controller.guides.update_fail")
      return redirect_to guides_update_path
    end
    return redirect_to root_path
  end

  #
  def save
    
    @guide = Guide.new(params[:guide])
    
    @guide.parent_id = -1
    if @guide.save
      flash[:notice] = I18n.t("controller.guides.save_success")
    else
      flash[:error] = I18n.t("controller.guides.save_fail")
      return redirect_to guides_new_path
    end
    return redirect_to root_path
  end

  # edit Guide Object
  def edit
    @guide = Guide.find(params[:id])
    if @guide == nil
      flash[:error] = I18n.t("controller.guides.edit_fail")
    end
  end

  # delete Guide Object
  def remove
    @guide = Guide.find(params[:id])
    if !@guide.destroy
      flash[:error] = I18n.t("controller.guides.remvoe_fail")
    end
    return redirect_to root_path
  end
  
end
