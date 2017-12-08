class AsyncBroadcastJob < ApplicationJob
  queue_as :default
 
  def perform(document_id)
  	# p document_id = eval(document_id)
    ActionCable.server.broadcast 'home_channel', document_id: document_id  # render_message(document_id)
  end
 
  private
    def render_message(document_id)
      ApplicationController.renderer.render(partial: 'tests/test', locals: { document_id: document_id })
    end
end
