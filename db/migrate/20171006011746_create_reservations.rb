class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :listing, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :self_booking

      t.timestamps
    end
  end
end
