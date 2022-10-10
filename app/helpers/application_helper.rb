module ApplicationHelper
  include Pagy::Frontend
  def is_admin?
    if current_user.admin
      return true
    else
      return false
    end
  end

  def has_user_image(user)
    if user.avatar.nil?
      return false
    else
      if user.avatar.image.attached?
        return true
      else
        return false
      end
    end
  end
end
