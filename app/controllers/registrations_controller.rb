class RegistrationsController < Devise::RegistrationsController

    def sign_up_params
        params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end

    def account_update_params
        params.require(:user).permit(:email, :username, :password, :password_confirmation, :current_password, :biography)  
    end

    protected 

    def update_resource(resource, params)
        return super if params["password"]&.present?

        resource.update_without_password(params.except("current_password"))
    end
end
