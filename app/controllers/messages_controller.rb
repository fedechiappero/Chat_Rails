class MessagesController < ApplicationController
  def destroy
    @messages = Message.find_by(:chat_room_id => params[:id])
    @messages.destroy
  end
end