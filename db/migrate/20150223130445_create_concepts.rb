class CreateConcepts < ActiveRecord::Migration
  def change
    create_table :concepts do |t|
      t.string :term
      t.text :concept_text
      t.integer :solution_id

      t.timestamps
    end
  end
end
