class ParticipantsController < ApplicationController
  def destroy
    @participant = Participant.find_by(:user_id => current_user.id, :chat_room => params[:id])

    #@participant.destroy#elimino al participante

    @chat_room = ChatRoom.find(params[:id])#busco el chat

    if @chat_room.user_ids.count == 1#si no tiene mas participantes, se elimina con todo y mensajes

      #redirect_to chat_room_path(@chat_room), action(:destroy) and return
      redirect_to :controller => 'chat_rooms', :action => 'destroy', id: params[:id] and return
      #redirect_to :controller => 'post', :action => 'index'
    end
    flash[:success] = 'You just left the chat.'
    redirect_to users_path
  end
end
