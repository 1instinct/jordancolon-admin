require 'pusher'

# raise "PusherKeysMissingException" if PUSHER_APP_ID.empty? || PUSHER_APP_ID != ENV['PUSHER_APP_ID']

Pusher.app_id = ENV['PUSHER_APP_ID']
Pusher.key = ENV['PUSHER_KEY']
Pusher.secret = ENV['PUSHER_SECRET']
Pusher.cluster = ENV['PUSHER_CLUSTER']
Pusher.logger = Rails.logger
Pusher.encrypted = true

# pusher = Pusher::Client.new(
#   app_id: '1240460',
#   key: '51c778a7e0d1fdc07c42',
#   secret: 'e03d44ad2cbae879a12d',
#   cluster: 'us2',
#   encrypted: true
# )

# pusher.trigger('my-channel', 'my-event', {
#   message: 'hello world'
# })