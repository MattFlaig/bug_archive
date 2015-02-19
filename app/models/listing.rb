class Listing < ActiveRecord::Base
  belongs_to :user
  belongs_to :listingable, polymorphic: true
  validates_presence_of :snippet, :filename
end