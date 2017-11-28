class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :listing_title
      t.text :listing_content
      t.integer :price
      t.integer :goal_price
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
