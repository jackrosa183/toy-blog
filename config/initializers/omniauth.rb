Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
  Rails.application.credentials.dig(:twitter, :api_key), 
  Rails.application.credentials.dig(:twitter, :api_secret)

end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
  Rails.application.credentials.dig(:facebook, :api_id),
  Rails.application.credentials.dig(:facebook, :api_secret)

end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin,
  Rails.application.credentials.dig(:linkedin, :client_id),
  Rails.application.credentials.dig(:linkedin, :client_secret),
  scope: 'r_emailaddress'
end