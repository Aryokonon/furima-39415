class ApplicationController < ActionController::Base
  # USED INSTEAD OF REGISTRATIONS_CONTROLLERS
  # or SESSIONS_CONTROLLERS

  before_action :configure_permitted_parameters, if: :devise_controller?
  #  before_action :configure_sign_up_params, only: [:create]
  before_action :basic_auth

  def new
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [
        :nickname, :email, :password, :password_confirmation,
        :last_name, :first_name, :last_name_kana, :first_name_kana,
        :birthdate
      ]
    )
  end
end
