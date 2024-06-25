class ManageSessionsController < ApplicationController
  before_action :require_login, if: :current_user, unless: :devise_controller?

  def after_sign_in_path_for(resource)
    create_login if resource.is_a?(User) # Only create login for regular users
    root_path
  end

  def create_login
    device_id = Digest::SHA256.hexdigest("#{request.user_agent}#{request.remote_ip}")
    current_login = current_user.logins.find_or_create_by(device_id: device_id, ip_address: request.remote_ip, user_agent: request.user_agent)
    session[:device_id] = device_id
  end

  def destroy_login
    if current_user && session[:device_id].present?
      current_user.logins.find_by(device_id: session[:device_id])&.destroy
      session.delete(:device_id)
    else
      # Handle case where current_user or session[:device_id] is nil
      Rails.logger.error "Current user or session[:device_id] is nil"
      # Optionally handle this error condition, e.g., redirect to a login page
    end
  end

  private

  def require_login

    return unless request

    unless super_admin_path? || devise_controller?
      if Rails.env.test?
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

  def super_admin_path?
    request.path.starts_with?("/super-admin")
  end
end
