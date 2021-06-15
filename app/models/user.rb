class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :forum_threads, foreign_key: "author_id"
  has_many :forum_replies, foreign_key: "author_id"
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
end
