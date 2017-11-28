class AddBankNameAndBranchNameAndBankCodeAndBranchCodeAndAccountNumberAndAccountOwnerNameToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :bank_name, :string
  	add_column :users, :branch_name, :string
  	add_column :users, :bank_code, :string
  	add_column :users, :branch_code, :string
  	add_column :users, :account_number, :string
  	add_column :users, :account_owner_name, :string
  end
end
