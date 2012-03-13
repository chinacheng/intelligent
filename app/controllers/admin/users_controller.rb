class Admin::UsersController < AdminController

  before_filter :per_load
  def per_load
    @user = User.find_by_id(params[:id]) if params[:id]
  end

  def index
    @users = User.paginate(:per_page=>20,:page=>params[:page])
  end

  def destroy
    if @user.destroy
      flash[:notice] = I18n.t("comment.destroy_success")
    end
    redirect_to :action=>:index
  end

end
