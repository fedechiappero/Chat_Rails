class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  scope :participating, -> (user) do
    where('(participants.user_id = ?)', user.id)
  end

end
