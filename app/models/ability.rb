class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, to: :modify

    user ||= User.new

    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
      can :modify, ForumThread, author_id: user.id
    end
  end
end
