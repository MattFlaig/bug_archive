class Solution < ActiveRecord::Base
  belongs_to :bug

  validates_presence_of :solution, :explanation

end