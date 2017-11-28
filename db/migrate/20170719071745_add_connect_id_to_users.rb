class AddConnectIdToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :connect_id, :string
  end
end
