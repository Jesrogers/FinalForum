class ForumRepliesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_reply, only: [:edit, :update, :destroy]
    before_action :reply_authorize_check

    def create
        @forum_thread = ForumThread.find(params[:forum_thread_id])
        @forum_reply = @forum_thread.forum_replies.create(forum_reply_params)
        @forum_reply.author_id = current_user.id

        if @forum_reply.save
            redirect_to forum_thread_path(@forum_thread)
        else
            redirect_to forum_thread_path(@forum_thread), notice: "Reply successful."
        end
    end

    def edit
    end

    def update
        if @forum_reply.update(forum_reply_params)
            redirect_to forum_thread_path(@forum_reply.forum_thread), notice: "Reply updated."
        else
            render :edit
        end
    end

    def destroy
        @forum_reply.destroy
        redirect_to forum_thread_path(@forum_reply.forum_thread), notice: "Reply deleted."
    end

    private 
    
    def set_reply
        @forum_reply = ForumReply.find(params[:id])
    end
    
    def forum_reply_params
        params.require(:forum_reply).permit(:body)
    end
end
