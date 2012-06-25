class PicturesController < ApplicationController

  before_filter :per_load
  def per_load
    @host = Topic.find_by_id(params[:topic_id]) if params[:topic_id]
    @picture = Picture.find_by_id(params[:id]) if params[:id] 
  end

  def new
    @picture = Picture.new
  end

  def create
    @host.add_picture(current_user,params[:picture][:photo])
    redirect_to @host
  end

end
