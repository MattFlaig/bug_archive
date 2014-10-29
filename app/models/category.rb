class Category < ActiveRecord::Base
  has_many :bugs
end