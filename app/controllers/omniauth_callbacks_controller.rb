class OmniauthCallbacksController < ApplicationController
  def auth 
    request.env['omniauth.auth']
  end
  def twitter
    if current_user.twitter_account
    current_user.create_twitter_account(
      name: auth.info.name,
      username: auth.info.nickname,
      token: auth.credentials.token,
      secret: auth.credentials.secret,
      )
    render plain: auth.to_s
  end
  

end