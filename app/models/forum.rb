class Forum < ApplicationRecord
    belongs_to :channel
    has_many :forum_posts
end
