require 'test_helper'

class ColumnTest < ActiveSupport::TestCase
   test "Create Colums Success" do
     assert_difference "Column.count",1 do
      col = Column.new(:name=>"index",:sequence=>1,:show=>1,:way=>"1",
                  :parent_id=>-1)

      assert_equal true,col.valid?
      assert_equal true,col.save
     end
   end

  test "Columns Name is Null" do
    assert_difference "Column.count", 0 do
      col = Column.new(:sequence=>1,:show=>1,:way=>"1",
                  :parent_id=>-1)

      assert_equal false,col.valid?
      assert_equal false,col.save
    end
  end
  
  test "Columns Name too length" do 
    assert_difference "Column.count",0 do
      col = Column.new(:name=>"1234567890123456789012345678901234567",:show=>1,:way=>"1",
                :parent_id=>-1)
      assert_equal false,col.valid?
      assert_equal false,col.save
    end
  end

  
end
