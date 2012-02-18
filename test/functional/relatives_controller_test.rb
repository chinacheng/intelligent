require 'test_helper'

class RelativesControllerTest < ActionController::TestCase
  
  test "one user follow other one test" do
    lilei, lucy, kate = users("lilei"),users("lucy"),users("kate")
    # lilei login
    session[:current_user_id] = lilei.id
    assert_equal current_user, lilei

    # cancel follow her
    assert_difference "Relative.count",1 do 
      post :create,:id=>lucy.id
    end

    assert_equal true, lilei.fan?(lucy)

    # cancel follow her
    assert_difference "Relative.count",-1 do
      delete :destroy,:id=>lucy.id
    end 

    assert_equal false, lilei.fan?(lucy)
  end

end
