jQuery(document).on 'turbolinks:load', ->
  App.global_chat = App.cable.subscriptions.create {
    channel: "AppearancesChannel"
  },
  connected: ->

  disconnected: ->

  received: (data) ->
    user = $(".user-#{data['user_id']}")
    user.toggleClass 'online', data['online']