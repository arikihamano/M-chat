class UsersController < ApplicationController

  def index
    
    @users = if params[:search]
      @users= User.where.not(id:current_user.id).where('name LIKE ?', "%#{params[:search]}%")
    else
      @users= User.where.not(id:current_user.id)
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end
end
