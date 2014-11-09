class User < ActiveRecord::Base
  has_many :bugs

  validates_presence_of :email, :name, :password
end