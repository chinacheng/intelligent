# encoding: utf-8

require 'test_helper'

class GuideTest < ActiveSupport::TestCase
  test 'Create guides Success' do
    lilei = users(:lilei)
    count = Guide.list_display.size
    assert_difference ['Guide.count', 'lilei.guides.count'], 1 do
      guide_tmp = Guide.new(:name => 'index',
                            :uri => 'index',
                            :sequence => 1,
                            :is_show => true,
                            :way => '1',
                            :parent_id => -1,
                            :user_id => lilei.id)
      assert guide_tmp.valid?
      assert guide_tmp.save

      assert_equal count + 1, Guide.list_display.size

      guide = Guide.last
      assert_equal lilei, guide.user
      assert_equal guide.author, 'lilei'

      assert_equal lilei.guides.size, 1
      assert lilei.guides.include?(guide)
    end
  end

  test 'Guides Sequence is Null' do
    lilei = users(:lilei)
    assert_difference 'Guide.count',1 do
      guide_tmp = Guide.new(:name => 'index1',
                            :uri => 'index1',
                            :is_show => true,
                            :way => '1',
                            :parent_id => -1,
                            :user_id => lilei.id)
      assert guide_tmp.valid?
      assert guide_tmp.save
    end
  end

  test 'Guides Name is Null' do
    assert_no_difference 'Guide.count' do
      col = Guide.new(:sequence => 1,
                      :is_show => true,
                      :way => '1',
                      :parent_id => -1)

      assert !col.valid?
      assert !col.save
    end
  end

  test 'Guides Name too length' do 
    assert_difference 'Guide.count',0 do
      col = Guide.new(:name => '1234567890123456789012345678901234567',
                      :is_show => true,
                      :way => '1', 
                      :parent_id => -1)
      assert_equal false,col.valid?
      assert_equal false,col.save
    end
  end

  test 'url of the guide, parent of the guide and the list display' do
    lilei = users('lilei')
    root_guide = nil
    assert_difference('Guide.list_display.count', 1) do
      root_guide = Guide.create(:name => 'index',
                                :sequence => 1,
                                :is_show => true,
                                :way => '1',
                                :parent_id => -1,
                                :user_id => lilei.id)
      assert_equal root_guide.uri_path, "/"
      assert_equal root_guide.parent, nil
    end

    assert_difference('Guide.list_display.count', 0) do
      child_guide = Guide.create(:name => 'index',
                                 :sequence => 1,
                                 :uri => '/child',
                                 :is_show => false,
                                 :way => '1',
                                 :parent_id => root_guide.id,
                                 :user_id => lilei.id)
      assert_equal child_guide.uri_path, '/child'
      assert_equal child_guide.parent, root_guide
    end
  end

end
