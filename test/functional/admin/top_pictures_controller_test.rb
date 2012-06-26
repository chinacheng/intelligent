require 'test_helper'

class Admin::TopPicturesControllerTest < ActionController::TestCase
  
  test "normal user can't top a picture" do
    user_login(users('lilei'))
    picture = pictures('picture_of_lilei')
    post :create, :picture_id => picture.id
    assert_response 403
  end

  test "admin can top a picture" do
    admin_login
    tops_size = TopPicture.tops.size
    picture = pictures('picture_of_lilei')
    assert_difference "TopPicture.count", 1 do
      post :create, :picture => picture.id
    end
    assert_equal tops_size + 1, TopPicture.tops.size
  end

end
