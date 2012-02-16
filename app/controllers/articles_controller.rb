class ArticlesController < ApplicationController
  before_filter :per_load
  
  def per_load
    @article=Article.find_by_id(params[:id]) if params[:id]
  end

  def index 
    @articles = Article.list(10)
  end

  def create
    @article = Article.new(params[:article])
    
    if !@article.save
      flash[:error] = I18n.t("controller.article.save_fail")
    end
    return redirect_to article_list_path
  end

  def new 
    @article = Article.new
  end

  def edit
  end

  def update
    if !@article.update_attributes(params[:article])
      flash[:error] = I18n.t("controller.article.update_fail")
      return redirect_to article_update_path
    end
    return redirect_to article_list_path        
  end

  def destroy
    if !@article.destroy
      flash[:error] = I18n.t("controller.article.remvoe_fail")
    end
    return redirect_to article_list_path
  end

  def remove_batch

  end

end
