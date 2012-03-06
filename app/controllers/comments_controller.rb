# encoding: utf-8

class CommentsController < ApplicationController

  skip_before_filter :login_require, :only=>[:index]

  before_filter :per_load
  def per_load
    @host = Article.find_by_id(params[:article_id]) if params[:article_id]
    @comment = Comment.find_by_id(params[:id]) if params[:id]
  end

  before_filter :check_user_auth,:only=>[:destroy]
  def check_user_auth
    if current_user != @comment.user
      return render :status=>404,:text=>"you are in the wrong page!"
    end
  end

  def index
    @host.comments.paginate(:per_page=>20,:page=>params[:page])
  end

  def create
    @comment = @host.comments.new(params[:comment])
    @comment.user = current_user
    @comment.address = request.remote_ip
    if @comment.save
      flash[:notice] = I18n.t("controller.save_sucess")
      return redirect_to_by_host_type(@host)
    end
    render :text=>"error",:status=>"500"
  end

  def redirect_to_by_host_type(host)
    case host.class.to_s
    when "Article" then redirect_to article_path(@comment.host_id)
    end
  end

  # TODO who can delete the comment ? it is not sure
  def destroy
    if @comment.destroy
      return redirect_to_by_host_type(@comment.host)
    end
  end

end
