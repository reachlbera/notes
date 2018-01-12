App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    console.log('qwer')
    # Called when the subscription is ready for use on the server
 
  disconnected: ->
    # Called when the subscription has been terminated by the server
 
  received: (data) ->
    console.log(data)
    $('.main-data').append(data['html_page'])
    # Called when there's incoming data on the websocket for this channel
 
  info_input: (message) ->
    @perform 'input', message: message
  submit: (data) ->
    @perform 'submit', data: data
 
$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.room.info_input event.target.value
    event.target.value = ""
    event.preventDefault()
#$(document).on 'click','#submit_setup_room',(event) ->
  #data = $('#submit_setup_room').parents('form').serialize()
  #App.room.submit data
  #event.preventDefault()