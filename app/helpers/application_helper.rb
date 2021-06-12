module ApplicationHelper
    def user_has_role?(role)
        current_user && current_user.has_role?(role)
    end

    def author_has_role?(author, role)
        author.has_role?(role) 
    end
end
