require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_url

    assert_response :success
    assert_equal @response.parsed_body.count, 2, "Should respond with all users"    
  end

  test "should get a user by id" do
    get user_url( users(:arnaud) )

    assert_response :success
    assert_equal @response.parsed_body["name"], "Arnaud", "Should respond with user Arnaud"    
  end

  test "should fail to get a user with false id" do
    get user_url( -1 )

    assert_response :bad_request
  end

  test "should create a user" do
    post users_url, params: { name: "Arandel" }

    assert_response :created
  end

  test "should not create a user without a name" do
    post users_url, params: {}

    assert_response :bad_request
  end

  test "should update a user" do
    patch user_url(users(:arnaud)), params: { name: "Arno" }
    
    assert_response :success
    assert_equal User.find(users(:arnaud).id).name, "Arno", "Should have changed the name of the user"
  end

  test "should not update a user with a false id" do
    patch user_url(-1), params: { name: "Arno" }
    
    assert_response :bad_request
  end

  test "should delete a user" do
    delete user_url(users(:arnaud))
    
    assert_response :success
    assert_equal User.all.count, 1, "Should have deleted one user"
  end

  test "should not delete a user with a false id" do
    delete user_url(users(:arnaud))
    
    assert_response :success
    assert_equal User.all.count, 1, "Should have deleted one user"
  end

end
