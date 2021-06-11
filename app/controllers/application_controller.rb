class ApplicationController < ActionController::Base
    helper_method [:thread_author_redirect, :reply_authorize_check]

    private 

    def thread_authorize_check
        unless current_user == @forum_thread.author
            redirect_to '/forums', flash: {alert: "You are not authorized to modify this thread."}
        end
    end

    def reply_authorize_check
        unless current_user == @forum_reply.author
            redirect_to '/forums', flash: {alert: "You are not authorized to modify this reply."}
        end
    end
end
