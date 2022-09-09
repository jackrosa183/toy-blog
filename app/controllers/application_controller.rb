class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  def authenticate_user! 
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path, notice: "Please login before continuing"
    end
  end
  def is_admin?
      if current_user.admin
        return true
      else
        return false
      end
  end
end
