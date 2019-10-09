class AddStateAndPayInIdToContribution < ActiveRecord::Migration[6.0]
  def change
    add_column :contributions, :aasm_state, :string
    add_column :contributions, :pay_in_id, :string
  end
end
