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
    else 
      current_user.twitter_account.update(
        name: auth.info.name,
        username: auth.info.nickname,
        token: auth.credentials.token,
        secret: auth.credentials.secret,
        )
      end
    redirect_to posts_path, notice: "Weclome  @#{current_user.twitter_account.username.to_s}"
  end

  def facebook
    if current_user.fb_account.nil?
      current_user.create_fb_account(
        uid: auth.uid,
        name: auth.info.name,
        email: auth.info.email,
        token: auth.credentials.token,
      )
    else 
      current_user.fb_account.update(
        uid: auth.uid,
        name: auth.info.name,
        email: auth.info.email,
        token: auth.credentials.token, 
      )
    end
    redirect_to posts_path, notice: "Weclome #{current_user.fb_account.name}"
  end

  def linkedin
    # binding.pry
    # # read 'code' and 'state' url arguments and make post request
    # exchange = Faraday.new(
    #   url: "https://www.linkedin.com/oauth/v2/accessToken",
    #   params: { grant_type: "authorization_code", code: "string",
    #           client_id: Rails.application.credentials.dig(:linkedin, :client_id),
    #           client_secret: Rails.application.credentials.dig(:linkedin, :client_secret),
    #           redirect_uri: posts_path }
    #   headers: { 'Content-Type' => 'x-www-form-urlencoded'}
    # )
    # response = exchange.post('/post') do |req|
    # end
    render plain: "#{auth}"
  end
end