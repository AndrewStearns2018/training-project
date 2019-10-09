class AddMagoWalletIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mango_wallet_id, :string
  end
end
