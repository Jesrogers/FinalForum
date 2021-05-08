class Forum < ApplicationRecord
    belongs_to :forum_category
    has_many :forum_posts
end
