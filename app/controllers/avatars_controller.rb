class AvatarsController < ApplicationController
  def new
    @avatar = Avatar.new
  end

  def create
    current_user.avatar.destroy
    @avatar = current_user.create_avatar(avatar_params)
    @avatar.image.attach(params[:avatar][:image])
    redirect_to user_path(current_user.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end
  private

  def avatar_params 
    params.require(:avatar).permit(:image, :user)
  end
end
