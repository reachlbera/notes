class UpdateChannel < ApplicationCable::Channel
  def subscribed
    stream_from "update_channel"
    p "wergdsfgdbx"
    p params
  end
 
  def unsubscribed
    p "dis_disksjdfsdf"
    p params
    # Any cleanup needed when channel is unsubscribed
  end
 
  def update_info(data)
    p "__________update_info_______#{data}_____________\n"
    # p data
    # ActionCable.server.broadcast "room_channel", message: data['message']
    # Room.create({doctor: data['message']})
    # Room.update({doctor: data['message']})
    # Message.new()
    # UpdateBroadcastJob.perform_later message:data['message']
  end

  def complite_num(data)
    p "complite_num",data["message"]
    Complite.always data
  end

  def update_message(data)
    p data
    UpdateBroadcastJob.perform_later message:data['message']    
  end
  def submit(data)
    # p data
  end
end
