# encoding: utf-8

class Admin::TopPicturesController < AdminController 

  before_filter :per_load
  def per_load
    @picture = Picture.find_by_id(params[:picture_id]) if params[:picture_id]
    @top_picture = TopPicture.find_by_id(params[:id]) if params[:id]
  end

  def index
    @top_pictures = TopPicture.paginate(:per_page => 20, :page => params[:page], :order => 'created_at desc')
  end

  def create
    render(:status => 200, :text => 'success') if TopPicture.top(current_user, @picture) 
  end

  def destroy
    picture = @top_picture.blank? ? @picture : @top_picture.picture
    return render(:status => 404, :text => "picture is not found") if picture.blank?
    respond_to do |format|
      if TopPicture.cancel_top(current_user, picture)
        format.html{redirect_to :action => :index}
        format.js do
          render(:status => 200, :text => 'success')
        end
      end
    end
  end

end
