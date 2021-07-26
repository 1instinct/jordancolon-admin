json.extract! @message, :id, :username, :message
json.url message_url(@message, format: :json)