class ForumRepliesController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource only: [:edit, :update, :destroy]

    def create
        @forum_thread = ForumThread.find(params[:forum_thread_id])
        @forum_reply = @forum_thread.forum_replies.build(forum_reply_params)
        @forum_reply.author_id = current_user.id

        if @forum_reply.save
            redirect_to forum_thread_path(@forum_thread)
        else
            redirect_to forum_thread_path(@forum_thread)
        end
    end

    def edit
    end

    def update
        if @forum_reply.update(forum_reply_params)
            redirect_to forum_thread_path(@forum_reply.forum_thread)
        else
            render :edit
        end
    end

    def destroy
        redirect_to forum_thread_path(@forum_reply.forum_thread), notice: "Reply deleted."
    end

    private 
    
    def forum_reply_params
        params.require(:forum_reply).permit(:body)
    end
end
