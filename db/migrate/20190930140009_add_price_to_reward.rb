class AddPriceToReward < ActiveRecord::Migration[6.0]
  def change
    add_column :rewards, :price, :float
  end
end
