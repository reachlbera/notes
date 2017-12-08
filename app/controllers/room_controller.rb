#encoding: utf-8
class RoomController < ApplicationController
	# before_filter :authenticate_user!
	# before_filter :get_user
	@@get_time_label=true
	def index
		@messages = Room.all
	end

	def edit
		
	end

	def show
		# @room = nil
		# p room_no = params[:id]
		# room = Room.where(:room_no=>room_no)
		# if room
		# 	@room
		# else
		# 	@room = Room.create({room_no: room_no})
		# end
		# @room
	end

	# POST
	def create
		
	end

	# PATCH/PUT 
	def update
		# p "__________________________\n"
		# p params
		# p "_______update end___________________\n"
	end

	def setup
		# @room = nil
		# p params
		# if params[:get]
		# 	get = params[:get]
		# 	@room = Room.where(:room_no=>get).last
		# else
		# end
		# if @@get_time_label == true
		# 	get_time
		# 	@@get_time_label = false
		# end
		# @room
		# @room = nil
		# p room_no = params[:id]
		# if room
		# 	@room
		# else
		# 	@room = Room.create({room_no: room_no})
		# end
		# @room		
	end

	def time_start
  	# headers={path:'timer',sender:'队列', receiver:'message.IM'}
  	# message={title:'update_time',method:'create',type:'every',content:'内容',repeat:'1m',alert:消息ID,first_at:(Time.now+30.second)}
  	# synchronous = MessageQueue::Synchronous.new(headers,message)
  	# result = synchronous.remote_call(message, headers)  		
	end

	private
	def get_time
		Thread.new {
			while 1<5 do
				time = Time.new
				second = time.sec
				if second>=1&&second<=3
				else
					wait_time = 60 - second
					sleep(wait_time)
				end
				time = Time.new.strftime("%Y-%m-%d %H:%M")
				time = "当前时间："+time.to_s
				TimeBroadcastJob.perform_later time:time
				sleep(60)
			end
		}
	end
end