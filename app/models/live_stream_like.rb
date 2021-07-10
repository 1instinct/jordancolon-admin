class LiveStreamLike < ApplicationRecord
  belongs_to :live_stream
  belongs_to :user
end
