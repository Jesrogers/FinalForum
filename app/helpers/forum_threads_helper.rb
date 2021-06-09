module ForumThreadsHelper

    def thread_author?(forum_thread)
        current_user == forum_thread.author
    end
end
