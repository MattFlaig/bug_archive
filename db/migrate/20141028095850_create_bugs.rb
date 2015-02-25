class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
    	t.string :name
    	t.text :description
    	t.string :message
    	t.string :environment
    	t.boolean :solved?
    	t.integer :category_id

    	t.timestamps
    end
  end
end
