class ThreadTable < Spree::Base
  has_one :live_stream, dependent: :destroy
  has_one :actor, dependent: :destroy
  has_many :messages, dependent: :destroy
  self.whitelisted_ransackable_attributes = %w[id]
  after_create :notify_pusher

  def notify_pusher
    Pusher.trigger('chat', 'new-chatroom', self.as_json)
  end
end
