class TopicsController < ApplicationController

  skip_before_filter :login_require, :only=>[:show, :index]
  before_filter :per_load
  def per_load
    @topic = Topic.find_by_id(params[:id])
  end

  def index
    @topics = current_user.topics.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(params[:topic])
    if @topic.save
      flash[:notice] = I18n.t("common.create_success")
      return redirect_to :action => :show, :id => @topic.id
    end
    render :action => :new
  end

  def edit
  end

  def update
    if @topic.update_attributes(params[:topic])
      flash[:notice]  = I18n.t("common.update_success")
      return redirect_to :action => :show, :id => params[:id]
    end
    render :action => :edit, :id => params[:id]
  end

  def show
  end

  def destroy
    if can_destroy?(@topic)
      flash[:notice] = @topic.destroy ? I18n.t("common.destroy_success") : I18n.t("common.destroy_fail")
      return redirect_to :action => :index
    end
    render :status => 403, :text => "error"
  end

  private
  def can_destroy?(topic)
    current_user.is_admin? || current_user == topic.user
  end
end
