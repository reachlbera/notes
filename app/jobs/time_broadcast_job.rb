class TimeBroadcastJob < ApplicationJob
  queue_as :default
 
  def perform(message)
  	p message[:time]
    ActionCable.server.broadcast 'room_channel', time: message[:time]
    # ActionCable.server.broadcast 'room_channel', patient_now: render_message(message), patient_wait: render_message(message),async_time: time
  end
 
  private
    def render_now(message)
    	p "message_____________#{message}___________render_message"
      ApplicationController.renderer.render(partial: 'messages/room', locals: { message: message })
    end

    def render_wait
      p "message_____________#{message}___________render_message"
      ApplicationController.renderer.render(partial: 'messages/room', locals: { message: message })      
    end
end
