class ChatRoom < ApplicationRecord
  has_many :participants
  has_many :users, through: :participants
  has_many :messages, dependent: :destroy

  validates :title, presence: true
end
