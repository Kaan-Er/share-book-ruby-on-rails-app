class UsersController < ApplicationController
  before_action :require_permission

  def index
    @user = User.find_by_id(params[:id])
    @users = User.all
    @books = Book.where('user_id': params[:id])
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def require_permission
    if !current_user
      redirect_to root_path
    end
  end

end
