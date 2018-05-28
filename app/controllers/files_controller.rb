class FilesController < ApplicationController
  # before_filter :authenticate_user!
  # # before_filter :authorize_resource
  
  def upload
    file,ori=nil,nil
    params[params[:container]].each {|k,v| ori=k;file=v}
    uid = params[:ori_id].to_s=='undefined' ? (current_user&&current_user.id) : params[:ori_id].to_s
    @attachment = Voc::Attachment.new(:file => file, :container_type=>params[:container], :ori_type=>ori, :ii=>uid)
    @attachment.author = current_user
    @attachment.filename ||= params[:filename].presence || current_user.id.to_s+'_'+rand(99999999).to_s(36)
    @attachment.save
  end

  def download
    if params[:id]
      @attachment = Voc::Attachment.find(params[:id]) rescue nil
    end
    if @attachment&&File.exist?(@attachment.diskfile)
       send_file @attachment.diskfile, :filename => @attachment.filename,
                                      :type => @attachment.content_type,
                                      :disposition =>'attachment'
    end
  end

  def delete
    if params[:id]
      @attachment = Voc::Attachment.find(params[:id]) rescue nil
    end
    if @attachment&&File.exist?(@attachment.diskfile)
      @attachment.destroy
    end
  end

  def get
    if params[:id]
      @attachment = Voc::Attachment.find(params[:id]) rescue nil
    else
      @attachment = Voc::Attachment.where(:container_type=>params[:container], :ori_type=>params[:ori_type], :ii=>params[:ori_id], :filename=>params[:filename]).last
    end
    if @attachment&&File.exist?(@attachment.diskfile)
       send_file @attachment.diskfile, :filename => @attachment.filename,
                                      :type => @attachment.content_type,
                                      :disposition => (@attachment.content_type.to_s=~/image/ ? 'inline' : 'attachment')
    end
  end

  def get_container_file_names
    p params
    uid = (params[:ori_id].nil?||params[:ori_id].to_s=='undefined') ? (current_user ? current_user.id.to_s : 'public') : params[:ori_id].to_s
    @attachments = Voc::Attachment.where(:container_type=>params[:container], :ori_type=>params[:ori_type], :ii=>uid)
  end
  
end
