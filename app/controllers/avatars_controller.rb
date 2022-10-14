class AvatarsController < ApplicationController
  before_action :set_avatar, only: [:update, :destroy]

  def new
    @avatar = Avatar.new
  end

  def create
    @avatar = current_user.create_avatar(avatar_params)
    @avatar.image.attach(params[:avatar][:image])
    if @avatar.save
      redirect_to user_path(current_user.id), notice: "Avatar successfully created"
    else
      redirect_to user_path(current_user.id), alert: @avatar.errors.full_messages
    end
  end

  def edit
    @avatar = User.find(params[:id]).avatar
  end

  def update
    @avatar.image.purge
    @avatar.image.attach(params[:avatar][:image])
    if @avatar.save
      redirect_to user_path(current_user.id), notice: "Avatar successfully changed"
    else
      redirect_to user_path(current_user.id), alert: @avatar.errors.full_messages
    end
      
  end

  def destroy
    if @avatar.destroy 
      redirect_to user_path(current_user.id), notice: "Avatar removed"
    else
      redirect_to user_path(current_user.id)
    end
  end
  private

  def set_avatar
    @avatar = Avatar.find_by(id: params[:id])
  end

  def avatar_params 
    params.require(:avatar).permit(:image, :user)
  end
end
