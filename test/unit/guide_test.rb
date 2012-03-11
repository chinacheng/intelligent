require 'test_helper'

class GuideTest < ActiveSupport::TestCase
   test "Create guides Success" do
     lilei = users(:lilei)
     assert_difference "Guide.count",1 do
      guide_tmp = Guide.new(:name=>"index",:uri=>"index",:sequence=>1,:is_show=>true,:way=>"1",:parent_id=>-1,:user_id=>lilei.id)
      assert_equal true,guide_tmp.valid?
      assert_equal true,guide_tmp.save

      guide = Guide.last
      assert_equal lilei,guide.user

      assert_equal lilei.guides.size, 1
      assert_equal lilei.guides.include?(guide), true
     end
   end

  test "Guides Name is Null" do
    assert_difference "Guide.count", 0 do
      col = Guide.new(:sequence=>1,:is_show=>true,:way=>"1",:parent_id=>-1)

      assert_equal false,col.valid?
      assert_equal false,col.save
    end
  end
  
  test "Guides Name too length" do 
    assert_difference "Guide.count",0 do
      col = Guide.new(:name=>"1234567890123456789012345678901234567",:is_show=>true,:way=>"1",:parent_id=>-1)
      assert_equal false,col.valid?
      assert_equal false,col.save
    end
  end
  
end
