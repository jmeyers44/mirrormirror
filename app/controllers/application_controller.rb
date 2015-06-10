class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # before_action :update_sanitized_params
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:sign_up, :sign_out, :sign_in]

  # def update_sanitized_params
  #   devise_parameter_sanitizer.for(:sign_up) << :username
  # end

end
