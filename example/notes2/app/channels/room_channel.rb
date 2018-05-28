class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
    p "wergdsfgdbx"
    p params
  end
 
  def unsubscribed
    p "dis_disksjdfsdf"
    p params
    # Any cleanup needed when channel is unsubscribed
  end
 
  def input(data)
    p "\n"
    p "__________________________room_speak___________#{data}___________________\n"
    # p data
    # ActionCable.server.broadcast "room_channel", message: data['message']
    # Room.create({doctor: data['message']})
    # Room.update({doctor: data['message']})
    # Message.new()
    RoomBroadcastJob.perform_later data
  end

  def submit(data)
    # p data
  end
end
