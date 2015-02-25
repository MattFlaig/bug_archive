class CreateSolutionConcepts < ActiveRecord::Migration
  def change
    create_table :solution_concepts do |t|
      t.integer :solution_id
      t.integer :concept_id  
    end
  end
end
