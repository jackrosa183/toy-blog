class UsersController < ApplicationController
  before_action :set_user, only: [:destroy, :show, :update]
  before_action :admin_check, only: [:index, :new, :create, :destroy]

  def index 
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User was successfully created"
    else
    end
  end

  def edit_avatar
    @user = current_user
  end

  def show
  end
  
  def update
    @user = current_user
    current_user.avatar.attach(params[:user][:avatar])
    current_user.save

    if current_user.update(user_params)
      sign_in(@user, bypass: true)
      redirect_to user_path(current_user.id), notice: "Woohoo! new account changes"
    else
      redirect_to edit_user_avatar_path, alert: @user.error.full_messages
    end
      
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User was succesfully destroyed"
  end

  private

  def admin_check
    unless current_user.admin
      redirect_to root_path, alert: "Administrator access required"
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :admin, :avatar)
  end

end
