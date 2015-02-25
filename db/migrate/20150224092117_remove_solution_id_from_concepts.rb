class RemoveSolutionIdFromConcepts < ActiveRecord::Migration
  def change
  	remove_column :concepts, :solution_id
  end
end
