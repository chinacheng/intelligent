class RelativesController < ApplicationController

  before_filter :per_load
  def per_load
    @user = User.find_by_id(params[:id]) if params[:id]
  end

  def create
    current_user.fan(@user)
    redirect_to user_path(@user.id)
  end

  def destroy
    current_user.unfan(@user)
    redirect_to user_path(@user.id)
  end

end
