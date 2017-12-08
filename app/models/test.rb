#encoding:utf-8
class Test
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongoid::Attributes::Dynamic
  field :state,        type: String  
  field :type,         type: String
  field :message,      type: String
  # field :content,      type: String

  after_save :hook_template

  def hook_template
  	data = {
  		id: self.id.to_s,
  		state: self.state,
  		message: self.message,
  		type:  self.type
  	}.to_s
    # MessageBroadcastJob.perform_later data
    info = {
      we: 23,
      hub: 423,
    }
    # RoomBroadcastJob.perform_later data,info
    p "_______________TimeBroadcastJob___++++ "
    TimeBroadcastJob.perform_later data: data,info: info
    p "_______________TimeBroadcastJob___++++_____end "    
  end


  # def get_timer
  #   Thread.new {
  #     i,b=1,5
  #     while i<b do
  #       time = Time.new.strftime("%Y-%m-%d %H:%M")
  #       TimeBroadcastJob.perform_later time:time
  #       sleep(60)
  #     end
  #   }     
  # end
    def verify
      FileUtils.mkdir('public/uploads/csv') unless File.exist?('public/uploads/csv')
      origin_file="public/uploads/tmp/#{avatar_cache}"
      md5 = Digest::MD5.hexdigest(File.open(origin_file){|f| f.read})
      @target_file="public/uploads/csv/#{File.basename(origin_file)[/(.*?)(\.\w+)?$/,1]}(#{md5}).csv"
      FileUtils.cp(origin_file,target_file)
      true
    end
end