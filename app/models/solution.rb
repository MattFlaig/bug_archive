class Solution < ActiveRecord::Base
  #include Codelistingable

  has_many :listings, :as => :listingable
  has_many :solution_concepts
  has_many :concepts, through: :solution_concepts 
  
  
  belongs_to :bug
  validates_presence_of :solution, :explanation

end