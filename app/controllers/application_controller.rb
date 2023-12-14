class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name posts_counter photo bio])
  end

  def after_sign_in_path_for(resource)
    if resource.name.blank? || resource.posts_counter.zero? || resource.photo.blank? || resource.bio.blank?
      complete_profile_users_path
    else
      users_path
    end
  end
end
