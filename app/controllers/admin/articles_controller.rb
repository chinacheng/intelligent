class Admin::ArticlesController < ApplicationController
  skip_before_filter :login_require

  before_filter :per_load
  def per_load
    @article=Article.find_by_id(params[:id]) if params[:id]
  end


  def index
  #  @articles = Article.list(20)
    @articles = Article.paginate(:page=>1,:per_page=>2)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    @article.user_id = current_user.id
    if @article.save
      flash[:notice] = I18n.t("controller.article.save_success")
      return redirect_to admin_articles_path
    end
    render :action=>:new
  end

  def edit
  end 

  def update
    if @article.update_attributes(params[:article])
      flash[:notice] = I18n.t("controller.article.edit_success")
      return redirect_to admin_articles_path
    end
    render :action=>:edit,:id=>params[:id]
  end

  def destroy
    if @article.destroy
      flash[:notice] = I18n.t("controller.destroy_success")
      return redirect_to admin_articles_path
    end
  end

  def back
    return redirect_to admin_articles_path
  end

  def view

  end

  def remove_batch

  end

  def openComm
    if !@article.update_attribute(:has_comm,Article::CMMT_OFF)
      flash[:error] = I18n.t("controller.update_fail")
    end

    return redirect_to admin_articles_path
  end

  def closeComm
    if !@article.update_attribute(:has_comm,Article::CMMT_OFF)
      flash[:error] = I18n.t("controller.update_fail") 
    end

    return redirect_to admin_articles_path
  end

  def pass
    if !@article.update_attribute(:is_pass,Article::PASS_ON)
      flash[:error] = I18n.t("controller.update_fail")
    end

    return redirect_to admin_articles_path
  end

  def notpass
    if !@article.update_attribute(:is_pass,Article::PASS_OFF)
      flash[:error] = I18n.t("controller.update_fail")
    end

    return redirect_to admin_articles_path
  end
end
