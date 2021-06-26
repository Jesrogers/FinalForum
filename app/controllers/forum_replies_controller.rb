class ForumRepliesController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource except: [:create]

    def create
        @forum_thread = ForumThread.find(params[:forum_thread_id])
        @forum_reply = @forum_thread.forum_replies.build(forum_reply_params)
        @forum_reply.author_id = current_user.id
        authorize! :create, @forum_reply

        if @forum_reply.save
            @forum_thread.update(updated_at: DateTime.now)
            redirect_to forum_thread_path(@forum_thread)
        else
            add_breadcrumb("Forums", "/forums")
            add_breadcrumb(@forum_thread.forum.title, forum_path(@forum_thread.forum))
            add_breadcrumb(@forum_thread.title)
            
            @reply_error = true
            flash.now[:alert] = "Error while posting reply"
            render "forum_threads/show"
        end
    end

    def edit
    end

    def update
        if @forum_reply.update(forum_reply_params)
            @forum_reply.forum_thread.update(updated_at: DateTime.now)
            redirect_to forum_thread_path(@forum_reply.forum_thread)
        else
            render :edit
        end
    end

    def destroy
        @forum_reply.destroy
        redirect_to forum_thread_path(@forum_reply.forum_thread), notice: "Reply deleted."
    end

    private 
    
    def forum_reply_params
        params.require(:forum_reply).permit(:body)
    end
end
