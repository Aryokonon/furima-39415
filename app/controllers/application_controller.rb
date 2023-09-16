class ApplicationController < ActionController::Base
# USED INSTEAD OF REGISTRATIONS_CONTROLLERS 
# or SESSIONS_CONTROLLERS

  before_action :configure_permitted_parameters, if: :devise_controller?
#  before_action :configure_sign_up_params, only: [:create]
#  before_action :basic_auth

    def create
      build_birth_date
      super
    end
  
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password, :password_confirmation, :last_name, :first_name, :last_name_kana, :first_name_kana, "birth_date(1i)", "birth_date(2i)", "birth_date(3i)"])
    end

    def new
    end

    private
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password, :password_confirmation, :last_name, :first_name, :last_name_kana, :first_name_kana, "birth_date(1i)", "birth_date(2i)", "birth_date(3i)"])
    end
  
    def build_birth_date
      date_params = params[:user].slice("birth_date(1i)", "birth_date(2i)", "birth_date(3i)")
      begin
        params[:user][:birth_date] = Date.new(date_params["birth_date(1i)"].to_i, date_params["birth_date(2i)"].to_i, date_params["birth_date(3i)"].to_i)
      rescue ArgumentError
        params[:user][:birth_date] = nil
        @user = User.new(params[:user])  # Initialize a User object to add errors to, if it's not already done
        @user.errors.add(:birth_date, "is not a valid date")
      end
    end
  end