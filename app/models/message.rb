class Message < ApplicationRecord
    belongs_to :author, class_name: "User"
    belongs_to :recipient, class_name: "User"
    belongs_to :parent, class_name: "Message", optional: true
end
