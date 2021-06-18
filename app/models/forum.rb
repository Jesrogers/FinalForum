class Forum < ApplicationRecord
    belongs_to :channel
    has_many :forum_threads, dependent: :destroy

    resourcify

    extend FriendlyId
    friendly_id :title, use: [:slugged, :finders]
  
    def should_generate_new_friendly_id?
      title_changed?
    end

    scope :ordered_by_position, -> { order(:position) }
end
