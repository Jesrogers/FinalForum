class ForumThreadsController < ApplicationController

    def show
        @thread = ForumThread.find(params[:id])
    end
end
