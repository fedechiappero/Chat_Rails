class ChatRoomsController < ApplicationController
  def index
    #@chat_rooms = ChatRoom.where user_id: current_user.id #NO ALL -> where chatroom.participantes.id = usuarioLogueado.id OR el logueado es el admin

    #@chat_rooms = ChatRoom.joins('INNER JOIN participants ON chat_rooms.id = participants.chat_room_id WHERE participants.user_id = ',current_user.id.to_s)
    @chat_rooms = ChatRoom.joins(:participants).where('participants.user_id' => current_user.id.to_s).distinct.order('chat_rooms.updated_at DESC')
    #render plain: @chat_rooms.inspect
    #@users = User.all
  end

  def new #para crear un nuevo chat
    @chat_room = ChatRoom.new
  end

  def create #guarda un chat en la db
    @chat_room = current_user.chat_rooms.build(chat_room_params)

    if @chat_room.valid?
      #tengo que ver como invertir la condicion del if para evitar este espacio
    else#no es valido porque falta el titulo, entonces se compone con el nombre de los usuarios
      title = ''
      @chat_room.user_ids.each do |iduser|
        @user = User.find(iduser)
        title += @user.name + ' '
      end
      @chat_room.title = title
    end

    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end

  end

  def update
    if params[:leave]
      @participant = Participant.find_by(:user_id => current_user.id, :chat_room => params[:chat_room_id])
      @participant.destroy
      flash[:success] = 'You just left the chat'
      redirect_to chat_rooms_path
    end
  end

  def show
    @chat_room = ChatRoom.includes(:messages).joins(:participants).find_by('chat_rooms.id' => params[:id], 'participants.user_id' => current_user.id.to_s)
    if @chat_room != nil
      @message = Message.new
    else
      not_found #en realidad deberia ser un 403
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, :user_ids => [])#permitimos que el usuario ingrese un titulo y los participantes
  end
end