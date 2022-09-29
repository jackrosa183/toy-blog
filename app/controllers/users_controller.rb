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

  def update_avatar
    debugger
    current_user.avatar.attach(params[:user][:avatar])
    puts current_user.avatar.attach(params[:user][:avatar])
    redirect_to user_path(current_user.id)
  end

  def show
  end
  
  def update
    # debugger
    current_user.avatar.attach(params[:user][:avatar])
    current_user.save
    puts current_user.avatar.attach(params[:user][:avatar]) 
    redirect_to user_path(@user.id)
    # @user.update_column(:avatar, params[:avatar])
    # if @user.update_column(:avatar, params[:avatar])
    #   redirect_to user_path(@user.id), notice: "Avatar successfully updated"
    # else
    #   redirect_to user_path(@user.id), alert: @user.errors.full_messages
    # end
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
