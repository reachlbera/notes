#encoding:utf-8
class Show
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongoid::Attributes::Dynamic
  # extend MessageQueue::Synchronous
  field :filename,       type: String     
  field :price,          type: String     
  field :descriptions,   type: String  
  field :status,         type: String  

  # after_update :hook_template

  def hook_template
    info = {
      we: 23,
      hub: 423,
    }
    UpdateBroadcastJob.perform_later info
    p "_______________TimeBroadcastJob___++++_____end "
  end

  # 消息处理
  def message_handler headers,message
    p "-----------message_handler-----#{Time.now()}----------"

  end
end