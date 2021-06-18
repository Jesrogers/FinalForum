class ForumThread < ApplicationRecord
    belongs_to :forum
    belongs_to :author, class_name: "User", foreign_key: "author_id"

    has_many :forum_replies, dependent: :destroy

    resourcify

    extend FriendlyId
    friendly_id :title, use: [:slugged, :finders]
  
    def should_generate_new_friendly_id?
      title_changed?
    end

    scope :ordered_by_updated, -> { order("updated_at DESC") }
end