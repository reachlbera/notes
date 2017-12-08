#encoding:utf-8
class Complite
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongoid::Attributes::Dynamic
  # extend MessageQueue::Synchronous
  field :room_no,        type: String      #房间号
  field :doctor,         type: String    #医生
  field :technical_title,      type: String    #职称
  field :see_doctor,      type: String    #病人（数量、实时名字数组）

  after_save :hook_template

  def hook_template
  	data = {
  		id: self.id.to_s,
  		room_no: self.room_no,
  		doctor: self.doctor,
      technical_title: self.technical_title,
  		see_doctor:  self.see_doctor
  	}.to_s
    info = {
      we: 23,
      hub: 423,
    }
    # RoomBroadcastJob.perform_later data,info
    p "_______________TimeBroadcastJob___++++ "
    TimeBroadcastJob.perform_later data,info
    p "_______________TimeBroadcastJob___++++_____end "
  end

  class << self
    def always data
      p "always------"
      p data

    end
  end

  # 消息处理
  def message_handler headers,message
    p "-----------message_handler-----#{Time.now()}----------"

  end
end