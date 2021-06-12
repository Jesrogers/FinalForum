class Channel < ApplicationRecord
    has_many :forums, dependent: :destroy

    resourcify

    scope :ordered_by_position, -> { order(:position) }
end
