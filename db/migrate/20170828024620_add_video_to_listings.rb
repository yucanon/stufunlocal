class AddVideoToListings < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :video, :string
  end
end
