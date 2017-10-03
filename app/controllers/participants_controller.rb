class ParticipantsController < ApplicationController

  def create#falta controlar que si el chat ya existe te mande derecho sin crearlo de nuevo

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


    # if @chat_room.count == 2
    #   redirect_to chat_room_path @chat_room[0].chat_room_id
    # else
    #   @chat_room = ChatRoom.new
    #   @chat_room.title = User.find(params[:id]).name
    #   @chat_room.user_ids = params[:id], current_user.id
    #
    #   if @chat_room.save
    #     redirect_to chat_room_path(@chat_room)
    #   else
    #     redirect_to users_path
    #   end
    # end


    #@chat_room_usuario1 = Participant.select(:chat_room_id).where(user_id: current_user.id)

    #@chat_room_usuario2 = Participant.select(:chat_room_id).where(user_id: params[:id])
    #ChatRoom.joins(:participants).where('participants.user_id' => current_user.id.to_s).distinct.order('chat_rooms.updated_at DESC')

    #render plain: @chat_room_usuario2.inspect

    # @chat_room_usuario1.each do |chat1|
    #   @chat_room_usuario2.each do |chat2|
    #     if chat1.chat_room == chat2.chat_room
    #       @cantidad = Participant.select(:chat_room_id).where(chat_room_id: chat1.chat_room_id).count
    #       if @cantidad == 2
    #         redirect_to chat_room_path @chat_room_usuario1
    #       end
    #     end
    #   end
    # end
    #render plain: @cantidad.inspect
    #render plain: 'no se encontro nada'.inspect


    #desde aca crea una nueva, sin corroborar si la ya existe (para arriba es todo prueba)
    # @chat_room = ChatRoom.new
    # @chat_room.title = User.find(params[:id]).name
    # @chat_room.user_ids = params[:id], current_user.id
    #
    # if @chat_room.save
    #   redirect_to chat_room_path(@chat_room)
    # else
    #   redirect_to users_path
    # end
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
