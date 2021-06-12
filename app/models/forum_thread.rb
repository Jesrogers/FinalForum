class ForumThread < ApplicationRecord
    belongs_to :forum
    belongs_to :author, class_name: "User", foreign_key: "author_id"

    has_many :forum_replies, dependent: :destroy

    resourcify

    scope :ordered_by_updated, -> { order("updated_at DESC") }
end