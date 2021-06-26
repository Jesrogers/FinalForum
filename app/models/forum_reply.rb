class ForumReply < ApplicationRecord
    validates :body, presence: true, length: { minimum: 20, maximum: 20000 }
    validates :author_id, presence: true
    validates :forum_thread_id, presence: true

    belongs_to :forum_thread
    belongs_to :author, class_name: "User", foreign_key: "author_id"

    resourcify
end
