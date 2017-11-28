class CreateCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :charges do |t|
      t.string :price
      t.references :user, foreign_key: true
      t.references :listing, foreign_key: true
      t.timestamps
    end
  end
end