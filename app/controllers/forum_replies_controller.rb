class ForumRepliesController < ApplicationController
    def create
        @thread = ForumThread.find(params[:forum_thread_id])
        @forum_reply = @thread.forum_replies.create(forum_reply_params)
        @forum_reply.author_id = current_user.id

        if @forum_reply.save
            redirect_to forum_thread_path(@thread)
        else
            redirect_to forum_thread_path(@forum_thread)
        end
    end

    private 
    
    def forum_reply_params
        params.require(:forum_reply).permit(:body)
    end
end
