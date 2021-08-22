class User < ApplicationRecord
    validates :name, presence: true

    has_many :messages, foreign_key: :author_id, dependent: :nullify
    has_many :messages, foreign_key: :recipient_id, dependent: :nullify

    has_many :archived_messages, foreign_key: :author_id, dependent: :nullify
    has_many :archived_messages, foreign_key: :recipient_id, dependent: :nullify

    before_destroy { |user| 
        Message.where(recipient_id: user.id).update_all(recipient_id: nil)
        Message.where(author_id: user.id).destroy_all
    }
end
