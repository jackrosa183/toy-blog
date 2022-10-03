class AvatarsController < ApplicationController
  def new
    @avatar = Avatar.new
  end

  def create
    # current_user.avatar.destroy
    # current_user.avatar.image.purge
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
    @avatar = Avatar.find_by(id: params[:id])
    @avatar.image.purge
    @avatar.image.attach(params[:avatar][:image])
    if @avatar.save
      redirect_to user_path(current_user.id), notice: "Avatar successfully changed"
    else
      redirect_to user_path(current_user.id), alert: @avatar.errors.full_messages
    end
      
  end

  def destroy
  end
  private

  def avatar_params 
    params.require(:avatar).permit(:image, :user)
  end
end
