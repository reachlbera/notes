class HomeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "home_channel"
  end
 
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
 
  def speak(data)
    p "_+_+___________+++++___________#{data}"
    # ActionCable.server.broadcast "room_channel", message: data['message']
    Test.create({message: data['message']})
    p "_+_+___________+++++___________speak_end____________\n"
    # Message.new()
  end
end
