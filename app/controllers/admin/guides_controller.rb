# encoding: utf-8

class Admin::GuidesController < AdminController

  before_filter :per_load
  def per_load
    @guide = Guide.find_by_id(params[:id]) if params[:id] 
  end

  def index
    @guides = Guide.paginate(:page=>params[:page],:per_page=>20,
                             :conditions=> ['name like ?',"%#{params[:search]}%"],
                             :order => "updated_at DESC")
  end

  def new
    @guide = Guide.new
  end

  def create 
    @guide = Guide.new(params[:guide])
    @guide.user_id = current_user.id

    if @guide.save
      flash[:notice] = I18n.t("controller.guides.save_success")
      return redirect_to :action=>:index
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
      return redirect_to :action=>:index
    end
    flash[:error] = I18n.t("controller.guides.update_fail")
    return redirect_to :action=>:edit,:id=>params[:id] 
  end

  def destroy 
    if @guide.destroy
      flash[:notice] = I18n.t("controller.guides.remvoe_success")
      redirect_to :action=>:index
    end
  end

end
