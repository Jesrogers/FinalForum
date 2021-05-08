class ForumPost < ApplicationRecord
    belongs_to :forum
    belongs_to :author, class_name: "User"
end
