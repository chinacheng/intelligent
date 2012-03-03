# encoding: utf-8

class CommentsController < ApplicationController

  skip_before_filter :login_require, :only=>[:index]

  before_filter :per_load
  def per_load
    @host = Article.find_by_id(params[:article_id]) if params[:article_id]
    @comment = Comment.find_by_id(params[:id]) if params[:id]
  end

  def index
    @host.comments.paginate(:per_page=>20,:page=>params[:page])
  end

  def create
    @comment = @host.comments.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:notice] = I18n.t("controller.save_sucess")
      return redirect_to_by_host_type
    end
    render :text=>"error",:status=>"500"
  end

  def redirect_to_by_host_type
    case @host.class.to_s
    when "Article" then redirect_to article_path(params[:article_id])
    end
  end

  def destroy
    if @comment.destroy
      return redirect_to_by_host_type
    end
  end

end
