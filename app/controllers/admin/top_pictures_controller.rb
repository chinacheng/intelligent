# encoding: utf-8

class Admin::TopPicturesController < AdminController 

  before_filter :per_load
  def per_load
    @picture = Picture.find_by_id(params[:picture_id]) if params[:picture_id]
  end

  def create
    TopPicture.top(current_user, @picture) 
    render :status => 200, :text => 'success'
  end

end
