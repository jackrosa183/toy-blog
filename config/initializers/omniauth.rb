Rails.application.config.to_prepare do
  class OmniAuth::Strategies::LinkedIn 
    def token_params
      super.tap do |params|
        params.client_secret = options.client_secret
      end
    end
  end
end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider(:twitter,
  Rails.application.credentials.dig(:twitter, :api_key), 
  Rails.application.credentials.dig(:twitter, :api_secret))

  provider(:facebook,
  Rails.application.credentials.dig(:facebook, :api_id),
  Rails.application.credentials.dig(:facebook, :api_secret))

  provider(:linkedin,
  Rails.application.credentials.dig(:linkedin, :client_id),
  Rails.application.credentials.dig(:linkedin, :client_secret))
end

