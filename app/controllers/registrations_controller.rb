class RegistrationsController < Devise::RegistrationsController

    def sign_up_params
        params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end

    def account_update_params
        params.require(:user).permit(:email, :username, :password, :password_confirmation, :current_password, :biography)  
    end

    protected 

    def after_update_path_for(user)
        user_path(user)
    end

    def update_resource(user, params)
        return super if params["password"]&.present?

        user.update_without_password(params.except("current_password"))
    end
end
