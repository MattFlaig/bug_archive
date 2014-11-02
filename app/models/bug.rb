class Bug < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :solutions

  validates_presence_of :name, :description, :environment, :category_id
end