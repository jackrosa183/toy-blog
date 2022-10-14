class ThreedController < ApplicationController 
  def model
    duck = File.read("app/assets/3d/duck.gltf")
    helmet = File.read("app/assets/3d/helmet.gltf")
    if params[:type] == 'duck'
      render json: duck
    elsif params[:type] == 'helmet'
      render json: helmet
    end
  end
end