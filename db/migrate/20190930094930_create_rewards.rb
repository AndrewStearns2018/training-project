class CreateRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards do |t|
      t.string :name
      t.text :description
      t.integer :units
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
