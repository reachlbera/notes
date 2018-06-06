#encoding:utf-8
class File
  include Mongoid::Document
  include Mongoid::Timestamps	

  field :container_type, type: String
  field :ori_type, type: String
  field :filename, type: String
  field :disk_filename, type: String
  field :target_directory, type: String, :default=>DateTime.now.strftime("%Y/%m")
  field :filesize, type: String
  field :content_type, type: String
  field :digest, type: String
  field :downloads, type: Integer, :default=>0

  def file=(incoming_file)
    unless incoming_file.nil?
      @temp_file = incoming_file
      if @temp_file.size > 0
        if @temp_file.respond_to?(:original_filename)
          self.filename = @temp_file.original_filename
          self.filename.force_encoding("UTF-8") if filename.respond_to?(:force_encoding)
        end
        if @temp_file.respond_to?(:content_type)
          self.content_type = @temp_file.content_type.to_s.chomp
        end
        if content_type.blank? && filename.present?
          self.content_type = get_content(filename)
        end
        self.filesize = @temp_file.size
      end
    end  	
  end
end