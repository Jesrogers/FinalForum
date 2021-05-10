class Channel < ApplicationRecord
    has_many :forums

    scope :ordered_by_position, -> { order(:position) }
end
