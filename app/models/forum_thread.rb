class ForumThread < ApplicationRecord
    belongs_to :forum
    belongs_to :author, class_name: "User", foreign_key: "author_id"
end