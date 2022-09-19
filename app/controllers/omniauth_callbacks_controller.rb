class OmniauthCallbacksController < ApplicationController
  def auth 
    request.env['omniauth.auth']
  end
  def twitter
    if current_user.twitter_account.nil?
      current_user.create_twitter_account(
        name: auth.info.name,
        username: auth.info.nickname,
        token: auth.credentials.token,
        secret: auth.credentials.secret,
        )
      render plain: auth.to_s
    else 
      current_user.twitter_account.update(
        name: auth.info.name,
        username: auth.info.nickname,
        token: auth.credentials.token,
        secret: auth.credentials.secret,
        )
      render plain: "already exists " + current_user.twitter_account.username.to_s
    end
  end
  

end