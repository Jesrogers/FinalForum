class ForumThreadsController < ApplicationController

    def new
        @forum_thread = ForumThread.new
    end

    def create
        @forum_thread = ForumThread.new(forum_thread_params)
        @forum_thread.author_id = current_user.id

        if @forum_thread.save
            redirect_to forum_thread_path(@forum_thread)
        else
            render :new
        end
    end

    def show
        @forum_thread = ForumThread.find(params[:id])
    end

    private

    def forum_thread_params
        params.require(:forum_thread).permit(:title, :body, :forum_id)
    end
end
