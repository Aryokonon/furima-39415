module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    def create
      build_birth_date
      super
    end

    private

    def configure_sign_up_params
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
end