module ForumRepliesHelper
  def reply_author?(forum_reply)
    current_user == forum_reply.author
  end
end
