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

    build_title

    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end

  end

  def edit
    @chat_room = ChatRoom.find params[:id]
  end

  def update
    # if params[:leave]
    #   @participant = Participant.find_by(:user_id => current_user.id, :chat_room => params[:chat_room_id])
    #   @participant.destroy
    #   flash[:success] = 'You just left the chat'
    #   redirect_to chat_rooms_path
    # end

    @chat_room = ChatRoom.find params[:id]

    build_title

    @chat_room.update chat_room_params

    redirect_to chat_room_path
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

  def build_title
    #person.errors[:name]
    if @chat_room.errors[:title]
      title = ''
      @chat_room.user_ids.each do |iduser|
        @user = User.find(iduser)
        title += @user.name + ' '
      @chat_room.title = title
      end
    end
  end
end