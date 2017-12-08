#encoding: utf-8
class PictureController < ApplicationController
	# before_filter :authenticate_user!
	# before_filter :get_user
	# @@get_time_label=true
	def index
		# @messages = Room.all
		@pictures = File::Picture.all
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
	end

	def setup
	end


	private

end