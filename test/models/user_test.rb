require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Should not save a user without a name" do
    user = User.new
    assert_not user.save, "Saved the user without a name"
  end
  
  test "Should save a user with a name" do
    user = User.new(name: "Arandel")
    assert user.save, "Fail to save the user with a name"
  end  
  
  test "Should get a user with name 'Arnaud'" do
    assert_equal User.find_by(name: "Arnaud").name, "Arnaud", "Not found the user 'Arnaud'"
  end
end
