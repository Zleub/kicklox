require 'test_helper'

class UserTest < ActiveSupport::TestCase
  self.use_instantiated_fixtures = true
  
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

  test "Should get a user with id" do
    assert_equal User.find(@arnaud.id).name, "Arnaud", "Not found the user 'Arnaud'"
  end

  test "Should delete a user by id and all its messages" do
    User.find(@arnaud.id).destroy

    assert_equal Message.count, 1, "Should have deleted all messages except @five"
  end
end
