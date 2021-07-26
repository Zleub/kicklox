require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should save a message with a body, a public state, an author and a recipient" do
    user = User.find_by(name: "Arnaud")
    message = Message.new(body: "Hello World", public: true, author: user, recipient: user)
    assert message.save, "Failed to save a message with the basic parameters"
  end

  test "Should not save a message without a body" do
    user = User.find_by(name: "Arnaud")
    message = Message.new(public: true, author: user, recipient: user)
    assert_not message.save, "Saved a message without a body"
  end

  test "Should not save a message without a public state" do
    user = User.find_by(name: "Arnaud")
    message = Message.new(body: "Hello World", author: user, recipient: user)
    assert_not message.save, "Saved a message without a public state"
  end

  test "Should not save a message without a author" do
    user = User.find_by(name: "Arnaud")
    message = Message.new(body: "Hello World", public: true, recipient: user)
    assert_not message.save, "Saved a message without a author"
  end

  test "Should not save a message without a recipient" do
    user = User.find_by(name: "Arnaud")
    message = Message.new(body: "Hello World", public: true, author: user)
    assert_not message.save, "Saved a message without a recipient"
  end
  
  test "Should save a message with a parent" do
    user = User.find_by(name: "Arnaud")
    message = Message.find_by(body: "MyText")
    message = Message.new(body: "Hello World", public: true, author: user, recipient: user, parent: message)
    assert message.save, "Failed to save a message with a parent"
  end
end
