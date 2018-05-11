#encoding: utf-8
class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:index,:edit,:show,:create,:update]
	# before_action :get_user only: [:index,:edit,:show,:create,:update]
	# layout "home"
	# before_filter :get_user
	def index
		p "index"
		p params
		@users = User.all
		# @messages = Test.all
	end

	def edit
		p "edit"
		p params
	end

	def show
		p "show"
		p params
		@user = User.find(params[:id])
	end

	def create

	end

	def update
	end

	private
		# def get_user
		# 	:authenticate_user!
		# end
end