class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nationality, :string
    add_column :users, :country_of_residence, :string
  end
end
