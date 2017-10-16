class ChartsController < ApplicationController
  def index
    @participants = Participant.all
  end

  def users_by_chat
    result = Participant.group(:chat_room_id).count
    render json: [{name: 'Count', data: result}]
  end

  def popular_users
    result = Participant.group(:user_id).count
    render json: [{name: 'Count', data: result}]
  end

  def current_day_messages #no es current day, son los mensajes de toda la semana
    result = Message.where(created_at: Date.today-7..Date.today.end_of_day)
    result = result.group_by{|x| x.created_at.strftime('%Y-%m-%d')}
    chart_data = {}

    result.each do |a,b|
      chart_data.merge!({a => b.count})
    end
    render json: chart_data
  end
end
