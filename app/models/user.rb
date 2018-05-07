#encoding: utf-8
require 'devise/strategies/database_authenticatable'
# require 'database_authenticatable'
require 'ostruct'

class User
	include Mongoid::Document
  DEFAULT_PASSWORD = '123456'

devise :database_authenticatable, :registerable, :lockable,
  :recoverable, :rememberable, :trackable, :validatable

  field :login,                   type: String
  field :email,                  type: String
  field :username,                   type: String	
  field :encrypted_password,                   type: String	

  validates_presence_of       :login 
  validates_uniqueness_of     :login
  validates_presence_of       :email
  validates_uniqueness_of     :email

	# validates_presence_of :login
	# validates_uniqueness_of :login, :email #, :case_sensitive => false
	# attr_accessible :name, :email, :password, :password_confirmation, :remember_me

	def will_save_change_to_email?
	  false
	end
end