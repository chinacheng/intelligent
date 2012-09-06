# encoding: utf-8

require 'test_helper'

class TopPictureTest < ActiveSupport::TestCase

  test 'admin can top a picture to index' do

    assert_equal 0, TopPicture.tops.size

    picture = pictures('picture_of_lilei')
    admin, lilei = users('admin'), users('lilei') 
    
    assert_no_difference 'TopPicture.count' do 
      TopPicture.top(lilei, picture)
    end

    tp = nil
    assert_difference 'TopPicture.count', 1 do
      tp = TopPicture.top(admin, picture)
    end
    assert_not_nil tp
    assert_equal tp.picture, picture
    assert_equal tp.user, admin

    assert_equal 1, TopPicture.tops.size
    assert_equal picture, TopPicture.tops[0]
    assert picture.is_top?

    # a picture can set top only once
    assert_no_difference 'TopPicture.count' do
      TopPicture.top(admin, picture)
    end

    # a top picture can destroyed by admin
    assert_difference 'TopPicture.count', -1 do
      TopPicture.cancel_top(admin, picture)
    end

  end

end

