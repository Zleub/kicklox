require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "Should get Messages index" do
    get messages_url
    assert_response :success, "Response is not :success"
    assert_equal @response.parsed_body.length, Message.count, "Response body length != #{Message.count}"
  end
  
  test "Should get the first message" do
    get message_url(Message.first.id)

    assert_response :success, "Response is not :success"
    assert_equal @response.parsed_body["id"], Message.first.id, "Reponse body should be the requested message"
  end
  
  test "Should not get a message" do
    get message_url(-1)

    assert_response :bad_request, "Response is not :bad_request"
  end

  test "Should not create a message" do
    post messages_url, params: {}

    assert_response :bad_request
  end

  test "Should not create a message without a recipient" do
    post messages_url, params: { body: "message body", public: true, author: users(:arnaud)}

    assert_response :bad_request
  end

  test "Should not create a message without a author" do
    post messages_url, params: { body: "message body", public: true, recipient: users(:arnaud)}

    assert_response :bad_request
  end

  test "Should not create a message without a body" do
    post messages_url, params: { public: false, author: users(:arnaud), recipient: users(:arnaud)}

    assert_response :bad_request
  end

  test "Should not create a message without a public field" do
    post messages_url, params: { body: "message body", author: users(:toto), recipient: users(:arnaud)}

    assert_response :bad_request
  end
  
  test "Should create a message" do
    post messages_url, params: { body: 'Hello World', public: true, author: users(:arnaud).id, recipient: users(:toto).id }

    assert_response :created
    assert_equal Message.find(@response.parsed_body["id"]).body, "Hello World", "Should find the message we created"
  end

  test "Should create a message ignoring an inexistant parent" do
    post messages_url, params: { 
      body: 'Hello World', 
      public: true, 
      author: users(:arnaud).id, 
      recipient: users(:toto).id,
      parent: -1
    }

    assert_response :created
    my_message = Message.find(@response.parsed_body["id"])
    assert_equal my_message.body, "Hello World", "Should find the message we created"
    assert_nil my_message.parent, "Message created should not have a parent"
  end

  test "Should create a message to an existing parent" do
    post messages_url, params: {
      body: 'Hello World', 
      public: true, 
      author: users(:arnaud).id, 
      recipient: users(:toto).id,
      parent: messages(:one).id
    }

    assert_response :created
    my_message = Message.find(@response.parsed_body["id"])
    assert_equal my_message.body, "Hello World", "Should find the message we created"
    assert_not_nil my_message.parent, "Message created should have a parent"
    assert_equal my_message.parent, Message.find(messages(:one).id), "Should find the parent message"
  end
  
  test "Should not update a message" do
    patch message_url(Message.first.id), params: {}

    assert_response :bad_request
  end

  test "Should update a message" do
    patch message_url(Message.first.id), params: {
      public: true,
      body: 'new message'
    }

    assert_response :created
    assert_equal Message.first.body, "new message", "Message body should been changed"
    assert_equal Message.first.public, true, "Message public status should been changed"
  end

  test "Should destroy a message" do
    delete message_url(messages(:one).id)

    assert_response :ok
    assert_raises(ActiveRecord::RecordNotFound, "Should raise a RecordNotFound exception") { Message.find(messages(:one).id) }
  end

  test "Should not destroy a message with a false id" do
    delete message_url(-1)

    assert_response :bad_request
  end

  test "Should get the messages for user 2" do
    get "/users/#{User.first.id}/messages"

    assert_response :success, "Response is not :success"
    assert_instance_of Array, @response.parsed_body, "Response should have Array type" 
    assert_equal @response.parsed_body.length, 3, "Response should be a 3 length array"
    assert_equal @response.parsed_body[0]["recipient_id"], User.first.id, "Response.recipient is not #{User.first.id}"
  end
  
  test "Should not get any message for non existing user" do
    get "/users/-1/messages"

    assert_response :ok, "Response is not :ok"
    assert_instance_of Array, @response.parsed_body, "Response should have Array type" 
    assert_equal @response.parsed_body.length, 0, "Response is not empty"
  end

end
