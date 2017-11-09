class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  scope :participating, -> (user) do
    where('(participants.user_id = ?)', user.id)
  end

  after_destroy :delete_room?

  private

  def delete_room?
    if chat_room.user_ids.count == 0
      chat_room.destroy
    end
  end

end
