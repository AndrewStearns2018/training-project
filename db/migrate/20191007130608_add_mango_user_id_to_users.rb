class AddMangoUserIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mango_user_id, :string
  end
end
