class AddUserIdToConcepts < ActiveRecord::Migration
  def change
  	add_column :concepts, :user_id, :integer
  end
end
