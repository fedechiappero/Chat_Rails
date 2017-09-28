class ParticipantsController < ApplicationController

  def create#falta controlar que si el chat ya existe te mande derecho sin crearlo de nuevo
    @chat_room = ChatRoom.new
    @chat_room.title = User.find(params[:id]).name
    @chat_room.user_ids = params[:id], current_user.id

    if @chat_room.save
      redirect_to chat_room_path(@chat_room)
    else
      redirect_to users_path
    end
  end

  def destroy
    @participant = Participant.find_by(:user_id => current_user.id, :chat_room => params[:id])
    @participant.destroy#elimino al participante
    flash[:success] = 'You just left the chat.'

    @chat_room = ChatRoom.find(params[:id])#busco el chat

    if @chat_room.user_ids.count == 0#si no tiene mas participantes, se elimina con todo y mensajes

      #redirect_to chat_room_path(@chat_room), action(:destroy) and return
      redirect_to controller: :chat_rooms, action: :destroy, id: params[:id] and return #este llamado seria el que no anda
      #redirect_to :cas400ontroller => 'post', :action => 'index'
    end
    redirect_to chat_rooms_path
  end
end
