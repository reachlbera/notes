#encoding: utf-8
# require 'devise/strategies/database_authenticatable'
# require 'database_authenticatable'
# require 'ostruct'

class User
	include Mongoid::Document
  DEFAULT_PASSWORD = '123456'

devise :database_authenticatable, :registerable, :lockable,
  :recoverable, :rememberable, :trackable, :validatable

  field :login,                   type: String
  field :email,                  type: String
  field :username,                   type: String 
  field :status,                   type: String,default:"N"	

  ## Database authenticatable
  field :email,                   type: String
  field :encrypted_password,      type: String

  ## Recoverable
  field :reset_password_token,    type: String
  field :reset_password_sent_at,  type: Time

  ## Rememberable
  field :remember_created_at,     type: Time

  ## Trackable
  field :sign_in_count,           type: Integer, default: 0
  field :current_sign_in_at,      type: Time
  field :last_sign_in_at,         type: Time
  field :current_sign_in_ip,      type: String
  field :last_sign_in_ip,         type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  field :failed_attempts,        type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  field :unlock_token,           type: String # Only if unlock strategy is :email or :both
  field :ims_location_id,        type: String # Only if unlock strategy is :email or :both
  field :ims_location_name,      type: String # Only if unlock strategy is :email or :both
  field :locked_at,              type: Time


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

  def is_admin?
    login.to_s=='admin'
  end

  def is_manager?
    is_sys_admin?||false
  end


  def init_password
    self.update_attributes(:password=> DEFAULT_PASSWORD )
  end
  
end