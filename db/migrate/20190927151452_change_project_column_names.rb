class ChangeProjectColumnNames < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :landscape_image, :landscape_image_data
    rename_column :projects, :thumbnail_image, :thumbnail_image_data
  end
end
