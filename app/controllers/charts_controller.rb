class ChartsController < ApplicationController

  before_action :admin?

  def index
  end

  def users_by_chat
    result = Participant.group(:chat_room_id).count #this query doesnt reflect what i wanted to do
    render json: result.first(5)
  end

  def popular_users
    result = Participant.includes(:user).group(:user_id).order('count_id DESC').count('id')
    render json: result.first(5)
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

  def admin?
    if !current_user.admin
      redirect_to root_path
    end
  end

end
