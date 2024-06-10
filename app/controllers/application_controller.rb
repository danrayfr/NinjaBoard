class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def admin?
    redirect_to root_path, alert: "Unauthorized access to this application." unless current_user.admin?
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[username name email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
