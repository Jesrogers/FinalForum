class Forum < ApplicationRecord
  validates :title, presence: true, length: { maximum: 60 }
  validates :description, length: { maximum: 120 }
  validates :position, presence: true, numericality: { only_integer: true }
  validates :channel_id, presence: true

  belongs_to :channel
  has_many :forum_threads, dependent: :destroy

  resourcify

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  def should_generate_new_friendly_id?
    title_changed?
  end

  scope :ordered_by_position, -> { order(:position, :title) }
end
