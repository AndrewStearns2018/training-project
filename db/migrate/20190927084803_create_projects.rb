class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :short_description
      t.text :long_description
      t.integer :goal
      t.text :landscape_image
      t.text :thumbnail_image
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
