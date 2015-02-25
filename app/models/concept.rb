class Concept < ActiveRecord::Base
  has_many :solution_concepts
  has_many :solutions, through: :solution_concepts 

  belongs_to :user
  validates_presence_of :term, :concept_text
end