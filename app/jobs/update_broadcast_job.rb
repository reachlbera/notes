class UpdateBroadcastJob < ApplicationJob
  queue_as :default
 
  def perform(message)
    p message
    data = nil
    if message[:message]
      p "message"
      data =message
    elsif message[:picture]
      p "picture"
      data = message
    end
    if data
      p data
      ActionCable.server.broadcast 'update_channel', message: render_message(data)
    end
    # ActionCable.server.broadcast 'room_channel', patient_now: render_message(message), patient_wait: render_message(message),async_time: time
  end
 
  private
    def render_message(message)
    	p "message_____________#{message}___________render_message"
      ApplicationController.renderer.render(partial: 'messages/note', locals: { message: message })
    end
end
