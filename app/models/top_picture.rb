class TopPicture < ActiveRecord::Base
  
  validates_uniqueness_of :picture_id

  belongs_to :picture
  belongs_to :user

  # tops pictures show in index page
  def self.tops
    TopPicture.order("created_at desc").limit(4).map do |top_picture|
      top_picture.picture
    end
  end

  # create a top picture, but only admin can do this
  def self.top(user, picture)
    if user.is_admin?
      TopPicture.create(:user => user, :picture => picture)
    end
  end

end
