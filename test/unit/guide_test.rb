require 'test_helper'

class GuideTest < ActiveSupport::TestCase
   test "Create Colums Success" do
     assert_difference "Guide.count",1 do
      col = Guide.new(:name=>"index",:sequence=>1,:show=>1,:way=>"1",
                  :parent_id=>-1)

      assert_equal true,col.valid?
      assert_equal true,col.save
     end
   end

  test "Guides Name is Null" do
    assert_difference "Guide.count", 0 do
      col = Guide.new(:sequence=>1,:show=>1,:way=>"1",
                  :parent_id=>-1)

      assert_equal false,col.valid?
      assert_equal false,col.save
    end
  end
  
  test "Guides Name too length" do 
    assert_difference "Guide.count",0 do
      col = Guide.new(:name=>"1234567890123456789012345678901234567",:show=>1,:way=>"1",
                :parent_id=>-1)
      assert_equal false,col.valid?
      assert_equal false,col.save
    end
  end

  
end
