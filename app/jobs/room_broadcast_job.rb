class RoomBroadcastJob < ApplicationJob
  queue_as :default
 
  def perform(message)
  	p "_______________perform_____#{message}____________\n"
  	# p message = eval(message)
    # ActionCable.server.broadcast 'room_channel', message: {method: "#time_minute_show", time: '2012'}.to_s
    ActionCable.server.broadcast 'room_channel', html_page: render_message(message)
    #id  room_no  doctor  technical_title  see_doctor
  end
 
  private
    def render_message(message)
    	p "message_____________#{message}___________render_message"
      ApplicationController.renderer.render(partial: 'messages/info', locals: { message: message })
    end
end
