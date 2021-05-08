class ForumCategorysController < ApplicationController
    def index
        @forum_categories = ForumCategory.all
    end
end
