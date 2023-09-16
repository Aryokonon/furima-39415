class UsersController < ApplicationController
  def index
#    user = User.find(params[:id])
    redirect_to root_path
  end
end