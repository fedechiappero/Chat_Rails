class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room, :touch => true

  validates :body, presence: true, length: {minimum: 2, maximum: 1000}

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  #require 'encrypted_coder'
  serialize :body, EncryptedCoder.new

  def timestamp #desde que uso time_ago_in_words(message.timestamp) en la vista, este procedimiento no se usa
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
