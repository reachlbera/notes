class MessageBroadcastJob < ApplicationJob
  queue_as :default
 
  def perform(message)
  	p message = eval(message)
    ActionCable.server.broadcast 'home_channel', message: render_message(message)
  end
 
  private
    def render_message(message)
      ApplicationController.renderer.render(partial: 'tests/test', locals: { message: message })
    end
end
