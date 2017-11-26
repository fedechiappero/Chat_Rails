class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.joins(:participants).where('participants.user_id' => current_user.id.to_s).distinct.order('chat_rooms.updated_at DESC')
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create

    @chat_room = current_user.chat_rooms.build(chat_room_params)

    @chat_room.title = build_title

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

    @chat_room = ChatRoom.find params[:id]

    params[:chat_room][:title] = build_title

    if @chat_room.update(chat_room_params)
      flash[:success] = 'Chat room modified!'
      redirect_to chat_room_path
    else
      render 'edit'
    end

  end

  def show
    @chat_room = ChatRoom.includes(:messages).joins(:participants).includes(:users).find_by('chat_rooms.id' => params[:id], 'participants.user_id' => current_user.id.to_s)
    if @chat_room != nil
      @message = Message.new
    else
      not_found
    end
  end

  def destroy

    @chat_room = ChatRoom.find params[:id]

    if @chat_room.destroy
      redirect_to chat_rooms_path
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, :user_ids => [])
  end

  def build_title #if the user doenst type a title it be build with the participant's names
    if params[:chat_room][:title].blank? || params[:chat_room][:title] == '' || params[:chat_room][:title] == nil
      title = ''
      @chat_room.user_ids.each do |iduser|
        @user = User.find(iduser)
        title += @user.name + ' '
      end
      title
    else
      params[:chat_room][:title]
    end
  end
end