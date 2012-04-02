class Admin::CommentsController < AdminController
  
  before_filter :per_load
  def per_load
    @comment = Comment.find_by_id(params[:id]) if params[:id]
  end  

  def index
    @comments = Comment.paginate(:page=>params[:page],:per_page=>20,
               #   :select => "host_id,host_type,count(*) as created_at,max(updated_at) as updated_at",
                  :conditions=> ['content like ?',"%#{params[:search]}%"],
               #   :join => "as m LEFT JOIN articles a ON a.id=m.host_id",
               #   :group => "host_id,host_type",
                  :order => "created_at DESC")
  end

  def edit
    @comments = Comment.paginate(:page=>params[:page],:per_page=>10,
                  :conditions =>['host_id = ? AND host_type = ? AND content like ?',
                        "#{params[:host_id]}","#{params[:host_type]}","%#{params[:search]}%"],
                  :order => "created_at DESC")
  end

  def update
       
  end

  def destroy
    if @comment.destroy
      flash[:notice] = I18n.t("controller.destroy_success")
      return redirect_to admin_comments_path
    end
  end

  def toggle_allow_show
    if !@comment.toggle_allow_show
      flash[:error] = I18n.t("controller.update_fail")
    end
  
    case params[:source] 
      when "list" then return redirect_to admin_comments_path
      when "edit" then return redirect_to edit_admin_comment_path(:id => @comment.id,:host_id => @comment.host_id,
          :host_type => @comment.host_type,:search => params[:search])
    end  
  end

end
