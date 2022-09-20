Koala.configure do |config|
  config.app_access_token = '474834274659554|cQQyokZG5zquB2X99RfDtGLbt-0'
  config.access_token = 'EAAGv2ZChErOIBAMZA4dK8epPaZBQ8Kr0rQBpkyIyGBwJ1BfK51O7Nu04wDhqpK85uOosZByZBm192nGCBqzh8wm4N20KqF7ZC5cfrvOeBTE2UQDyeewg5Wai9dyZBvStS8aiqmS1754ZCiZAz2QGNInBRDW9on19I0hZBrmJiLdbDKxc8jFulq3rqEUqZBIO1ZAGE9L9j1mQJPiA7QZDZD'
  config.app_id = Rails.application.credentials.dig(:facebook, :api_id)
  config.app_secret = Rails.application.credentials.dig(:facebook, :api_secret)
end