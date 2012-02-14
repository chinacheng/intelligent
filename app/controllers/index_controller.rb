class IndexController < ApplicationController

  def index
    @guides = Guide.find(:all,
                    :conditions => ["parent_id=?",Guide::TOP_COLS],
                    :order => "sequence ASC")
  end

end
