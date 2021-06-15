class RegistrationsController < Devise::RegistrationsController

    def sign_up_params
        params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end

    def account_update_params
        params.require(:user).permit(:email, :username, :password, :password_confirmation, :biography)  
    end
end
