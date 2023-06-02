class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def authorize_admin
        unless current_user.admin?
        redirect_to home_index_path, notice: "You are not authorized to perform this action"
        end
    end
       

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :role])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :role])
    end
    def after_sign_in_path_for(resource)
        home_index_path
    end
end
   
