class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :require_login, if: :current_user

  # after_sign_in_path_for is triggered after require_login :(
    def after_sign_in_path_for(resource)
      if user_signed_in? && request.path.start_with?('/users')
        create_login
        root_path
      elsif super_admin_signed_in? && request.path.start_with?('/super-admin')
        super_admin_root_path
      else
        super
      end
    end

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

  private

  def create_login
    device_id = Digest::SHA256.hexdigest("#{request.user_agent}#{request.remote_ip}")
    current_login = current_user.logins.find_or_create_by(device_id: device_id, ip_address: request.remote_ip, user_agent: request.user_agent)
    session[:device_id] = device_id
  end

  # trigger this in your users/sessions_controller#destroy
  def destroy_login
    current_user.logins.find_by(device_id: session[:device_id])&.destroy
    session.delete(:device_id)
  end

  def require_login
    # return if controller_path == 'devise/sessions' && action_name == 'create' # if you trigger create_login in after_sign_in_path_for(resource)
    return if controller_path == 'users/sessions' && action_name == 'create' # if you trigger create_login in users/sessions_controller#destroy

    if Rails.env.test?
      # mock
      current_login = current_user.logins.create(device_id: "test_device_id")
    else
      current_login = current_user.logins.find_by(device_id: session[:device_id])
    end

    if current_login.nil?
      sign_out current_user
      redirect_to new_user_session_path, alert: "Device not recognized."
    end
  end
end
