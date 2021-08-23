require 'test_helper'

class ThreadsControllerTest < ActionDispatch::IntegrationTest
  test "Should get Threads index" do
    get threads_url

    assert_response :success, "Response is not :success"
    assert_equal @response.parsed_body.length, 2, "Response body length != 2"
  end

  test "Should get a thread by id" do
    get threads_url
    thread = @response.parsed_body[0]

    get "/threads/#{thread}"

    assert_response :success, "Response is not :success"
    assert_instance_of Array, @response.parsed_body, "Response should have Array type" 
    @response.parsed_body.each{ |msg| 
      assert_not_nil msg, "Message should not be nil"
    }
  end
  
  test "Should not get a thread with a false id" do
    get '/threads/-1'

    assert_response :bad_request, "Response is not :bad_request"
  end

  test "Should get messages from a thread for a specific user" do
    get threads_url
    thread = @response.parsed_body[0]
    toto = users(:toto)

    get "/users/#{toto.id}/thread/#{thread}"

    assert_response :ok, "Response is not :ok"
    assert_instance_of Array, @response.parsed_body, "Response should have Array type" 
    assert_equal @response.parsed_body.count, 2, "Response should be a 2 length array"
  end
end
