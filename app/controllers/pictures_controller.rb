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
    @pictures = @host.add_picture(current_user,params[:picture][:photo])
    respond_to do |format|
      format.html{ redirect_to @host }
    end
  end

  def destroy
    @picture.destroy
    render :json => true
  end

  def index
    return render :status => 200, :text => 'ok'
  end

end
