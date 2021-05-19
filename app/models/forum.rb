class Forum < ApplicationRecord
    belongs_to :channel
    has_many :forum_posts

    scope :ordered_by_position, -> { order(:order) }
end
