class Channel < ApplicationRecord
    has_many :forums, dependent: :destroy

    resourcify

    extend FriendlyId
    friendly_id :name, use: [:slugged, :finders]
  
    def should_generate_new_friendly_id?
      name_changed?
    end

    scope :ordered_by_position, -> { order(:position) }
end
