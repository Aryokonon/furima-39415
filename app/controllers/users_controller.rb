class UsersController < ApplicationController
  before_action :authenticate_user!, except: :index # Allow unauthenticated access to index
  def index
    #    user = User.find(params[:id])
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
    # Additional logic to display the user's profile
  end
end
