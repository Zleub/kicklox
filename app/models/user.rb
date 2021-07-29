class User < ApplicationRecord
    validates :name, presence: true

    has_many :messages, foreign_key: :author_id, dependent: :nullify
    has_many :messages, foreign_key: :recipient_id, dependent: :nullify

    has_many :archived_messages, foreign_key: :author_id, dependent: :nullify
    has_many :archived_messages, foreign_key: :recipient_id, dependent: :nullify
end
