class AddMoneyGiftToConversations < ActiveRecord::Migration[5.0]
  def change
  	add_column :messages, :moneygift, :string
  end
end
