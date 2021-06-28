module ForumThreadsHelper
  def thread_author?(forum_thread)
    current_user == forum_thread.author
  end

  def thread_author_redirect
    unless current_user == @forum_thread.author
      redirect_to '/forums'
    end
  end
end
