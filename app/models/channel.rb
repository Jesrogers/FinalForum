class Channel < ApplicationRecord
    has_many :forums, dependent: :destroy

    scope :ordered_by_position, -> { order(:position) }
end
