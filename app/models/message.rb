class Message < ApplicationRecord
    validates :body, presence: true
    validates :public, inclusion: [true, false]
    validates :author, presence: true
    validates :recipient, presence: true

    belongs_to :author, class_name: "User"
    belongs_to :recipient, class_name: "User"
    belongs_to :parent, class_name: "Message", optional: true

    before_destroy { |message| 
        Message.where(parent_id: message.id).destroy_all
        message.destroy
    }
end
