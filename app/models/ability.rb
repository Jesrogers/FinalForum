class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, to: :modify

    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all

      can :create, ForumThread, forum: { locked: false }
      can :modify, ForumThread, author_id: user.id, forum: { locked: false }
      
      can :create, ForumReply, forum_thread: { locked: false, forum: { locked: false } }
      can :modify, ForumReply, author_id: user.id, forum_thread: { locked: false, forum: { locked: false } }
    end
  end
end
