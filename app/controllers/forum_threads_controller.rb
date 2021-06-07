class ForumThreadsController < ApplicationController

    def show
        @forum_thread = ForumThread.find(params[:id])
    end
end
