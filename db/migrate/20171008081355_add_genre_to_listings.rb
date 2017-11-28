class AddGenreToListings < ActiveRecord::Migration[5.0]
  def change
  	add_column :listings, :genre, :string
  	add_column :listings, :picup, :integer
  end
end
