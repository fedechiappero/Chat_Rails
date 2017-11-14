module ChartsHelper
  def users_by_chat
    column_chart users_by_chat_charts_path, height: '500px', library: {
        title: {text: 'Users by chat'},
        yAxis: {
            allowDecimals: false,
            title: {
                text: 'Users count'
            }
        },
        xAxis: {
            title: {
                text: 'Chats'
            }
        },
        #refresh: 10
    }
  end

  def popular_users
    column_chart popular_users_charts_path, height: '500px', library: {
        title: {text: 'Popular users'},
        yAxis: {
            allowDecimals: false,
            title: {
                text: 'Chats'
            }
        },
        xAxis: {
            title: {
                text: 'Users'
            }
        }
    }
  end

  def current_day_messages
    line_chart current_day_messages_charts_path, height: '500px', library: {
        title: {text: 'Current week messages'},
        yAxis: {
            allowDecimals: false,
            title: {
                text: 'Messages'
            }
        },

        xAxis: {

        }
    }
  end
end
