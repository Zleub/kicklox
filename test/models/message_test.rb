require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "Should save a message with a body, a public state, an author and a recipient" do
    message = Message.new(body: "Hello World", public: true, author: users(:arnaud), recipient: users(:toto))
    assert message.save, "Failed to save a message with the basic parameters"
  end

  test "Should not save a message without a body" do
    message = Message.new(public: true, author: users(:arnaud), recipient: users(:toto))
    assert_not message.save, "Saved a message without a body"
  end

  test "Should not save a message without a public state" do
    message = Message.new(body: "Hello World", author: users(:arnaud), recipient: users(:toto))
    assert_not message.save, "Saved a message without a public state"
  end

  test "Should not save a message without a author" do
    message = Message.new(body: "Hello World", public: true, recipient: users(:toto))
    assert_not message.save, "Saved a message without a author"
  end

  test "Should not save a message without a recipient" do
    message = Message.new(body: "Hello World", public: true, author: users(:arnaud))
    assert_not message.save, "Saved a message without a recipient"
  end
  
  test "Should save a message with a parent" do
    message = Message.new(body: "Hello World", public: true, author: users(:arnaud), recipient: users(:toto), parent: messages(:one))
    assert message.save, "Failed to save a message with a parent"
  end

  test "Should destroy a message without a parent" do
    count = Message.count
    assert messages(:one).destroy, "Failed to destroy a message without a parent"
    assert_equal Message.count, count - 1, "Should have only deleted one message"
  end

  test "Should destroy a message with a parent" do
    count = Message.count
    assert messages(:seven).destroy, "Failed to destroy a message with a parent"
    assert_equal Message.count, count - 1, "Should have only deleted one message"
  end

  test "Should destroy a message with a parent and a child" do
    count = Message.count
    assert messages(:four).destroy, "Failed to destroy a message with a parent"
    assert_equal Message.count, count - 2, "Should have only deleted one message"
  end
end
