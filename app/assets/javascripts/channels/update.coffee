App.update = App.cable.subscriptions.create "UpdateChannel",
  connected: ->
    console.log('sadghar')
    # Called when the subscription is ready for use on the server
 
  disconnected: ->
    # Called when the subscription has been terminated by the server
 
  received: (data) ->
    console.log(data)
    $.message_notes(data)
 
  info_input: (message) ->
    @perform 'update_info', message: message

  message_puts: (message) ->
    @perform 'update_message', message: message    

  complite_num: (message) ->
    @perform 'complite_num', message: message    
     
$(document).on 'keypress', '[data-behavior~=update_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.update.info_input event.target.value
    event.target.value = ""
    event.preventDefault()

$(document).on 'keypress', '[name~=message]', (event) ->
  if event.keyCode is 13
    App.update.message_puts event.target.value
    event.target.value = ""
    event.preventDefault()

$(document).on 'keypress', '[name~=complite]', (event) ->
  if event.keyCode is 13
    App.update.complite_num event.target.value
    event.target.value=""
    event.preventDefault()