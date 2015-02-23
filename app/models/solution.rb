class Solution < ActiveRecord::Base
  #include Codelistingable

  has_many :listings, :as => :listingable
  has_many :concepts
  
  belongs_to :bug, :dependent => :destroy
  validates_presence_of :solution, :explanation

end