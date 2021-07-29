require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "Should get Messages index" do
    get messages_url
    assert_response :success, "Response is not :success"
    assert_equal @response.parsed_body.length, 3, "Response body length != 2"
  end
  
  test "Should get the first message" do
    get message_url(Message.first)

    assert_response :success, "Response is not :success"
  end

  test "Should get the first message for user 2" do
    get "/users/#{User.first.id}/messages"

    assert_response :success, "Response is not :success"
    assert_equal @response.parsed_body.length, 1, "Response should be a 1 length array"
    assert_equal @response.parsed_body[0]["recipient_id"], User.first.id, "Response.recipient is not #{User.first.id}"
  end

  test "Should not create a message" do
    post messages_url, params: {}

    assert_response :bad_request
  end
  
  test "Should create a message" do
    post messages_url, params: { body: 'Hello World', public: true, author: User.arnaud, recipient: User.toto }

    assert_response :created
  end

end
