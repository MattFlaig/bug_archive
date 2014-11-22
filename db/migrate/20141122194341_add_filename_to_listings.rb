class AddFilenameToListings < ActiveRecord::Migration
  def change
  	add_column :listings, :filename, :string
  end
end
