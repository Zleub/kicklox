ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  self.set_fixture_class author: User
  self.set_fixture_class recipient: User
  # Add more helper methods to be used by all tests here...
end
