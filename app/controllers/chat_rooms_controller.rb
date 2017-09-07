class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.all #NO ALL -> where chatroom.participantes.id = usuarioLogueado.id OR el logueado es el admin
  end

  def new #para crear un nuevo chat
    @chat_room = ChatRoom.new
  end

  def create #guarda un chat en la db
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    @chat_room
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  def edit

  end

  def show
    #if(el id del usuario logueado esta en los participantes) en caso de que ingrese la url del chat
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
    #else
    #no tiene permisos para estar aca (o alguna pagina de error 404)
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, :user_ids => [])#permitimos que el usuario ingrese un titulo y los participantes
  end
end