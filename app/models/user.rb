class User < ActiveRecord::Base
  has_many :bugs
  has_many :concepts
  
  has_secure_password
  
  validates_presence_of :email, :name, :password
end