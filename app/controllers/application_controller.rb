class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # before_action :update_sanitized_params
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:sign_up, :sign_out, :sign_in, :index]
  before_action :redirect_to_user_show, only: [:index]
  # def update_sanitized_params
  #   devise_parameter_sanitizer.for(:sign_up) << :username
  # end
  def redirect_to_user_show
    if current_user 
      if current_user.songs.count != 0
        redirect_to "/users/#{current_user.id}/loading"
      end
    end
  end


end
