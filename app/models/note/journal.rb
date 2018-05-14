#encoding: utf-8
# require 'devise/strategies/database_authenticatable'
# require 'database_authenticatable'
# require 'ostruct'

class Note::Journal
	include Mongoid::Document

  field :user_id,                  type: String
  field :user_name,                  type: String
  field :title,                  type: String
  field :article,                   type: String 
  field :status,                   type: String
  field :share,                   type: Boolean

  
end