class Forum < ApplicationRecord
    belongs_to :channel
    has_many :forum_threads, dependent: :destroy

    scope :ordered_by_position, -> { order(:position) }
end
