class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
    	t.string :solution 
    	t.string :explanation
    	t.string :related_links
    	t.integer :bug_id

    	t.timestamps
    end
  end
end
