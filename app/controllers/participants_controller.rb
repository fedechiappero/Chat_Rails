class ParticipantsController < ApplicationController

  def create

    @chat_room = Participant.find_by_sql(['SELECT chat_room_id FROM participants WHERE chat_room_id IN
                                          (SELECT chat_room_id FROM participants WHERE user_id = ? AND chat_room_id IN
                                          (SELECT chat_room_id FROM participants WHERE user_id = ? ))
                                          GROUP BY chat_room_id HAVING count(user_id) = 2',
                                          params[:id], current_user.id ])
    if @chat_room.empty?
      @chat_room = ChatRoom.new
      @chat_room.title = User.find(params[:id]).name
      @chat_room.user_ids = params[:id], current_user.id

      if @chat_room.save
        redirect_to chat_room_path(@chat_room)
      else
        redirect_to users_path
      end
    else
      redirect_to chat_room_path @chat_room[0].chat_room_id
    end

  end

  def destroy
    @participant = Participant.find_by(:user_id => current_user.id, :chat_room => params[:id])
    @participant.destroy#elimino al participante
    flash[:success] = 'You just left the chat.'

    redirect_to chat_rooms_path
  end
end
