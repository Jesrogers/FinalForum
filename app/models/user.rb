class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :trackable

  rolify

  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

  def should_generate_new_friendly_id?
    username_changed?
  end

  has_many :forum_threads, foreign_key: "author_id"
  has_many :forum_replies, foreign_key: "author_id"
end
