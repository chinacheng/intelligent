ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def current_user
    User.find_by_id(session[:current_user_id])
  end

  def admin_login
    session[:current_user_id] = users(:admin).id
  end

  def user_login(name)
    session[:current_user_id] = users(name).id 
  end
end
