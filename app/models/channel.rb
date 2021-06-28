class Channel < ApplicationRecord
  validates :name, presence: true, length: { maximum: 40 }
  validates :position, presence: true, numericality: { only_integer: true }

  has_many :forums, dependent: :destroy

  resourcify

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def should_generate_new_friendly_id?
    name_changed?
  end

  scope :ordered_by_position, -> { order(:position, :name) }
end
