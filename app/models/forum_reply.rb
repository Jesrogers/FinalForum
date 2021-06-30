class ForumReply < ApplicationRecord
  validates :body, presence: true, length: { minimum: 20, maximum: 20000 }

  belongs_to :forum_thread
  belongs_to :author, class_name: "User", foreign_key: "author_id"

  resourcify
end
