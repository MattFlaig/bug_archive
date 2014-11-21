class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
    	t.text :snippet
    	t.string :listingable_type
    	t.integer :listingable_id
    	t.integer :user_id

    	t.timestamps
    end
  end
end
