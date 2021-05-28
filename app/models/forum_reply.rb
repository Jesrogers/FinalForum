class ForumReply < ApplicationRecord
    belongs_to :forum_thread
    belongs_to :author, class_name: "User", foreign_key: "author_id"
end
