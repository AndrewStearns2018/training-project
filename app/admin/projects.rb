ActiveAdmin.register Project do
  permit_params :name, :short_description, :long_description, :goal, :category_id, :landscape_image, :thumbnail_image

  index do
    selectable_column
    id_column
    column :name
    column :goal
    column :created_at
    actions
  end

  filter :name
  filter :goal
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :category
      f.input :short_description
      f.input :long_description
      f.input :goal
      f.input :landscape_image, as: :file
      f.input :thumbnail_image, as: :file
    end
    f.actions
  end

  show do
    total = resource.contributions.sum(:amount)
     attributes_table do
       row :category
       row :short_description
       row :long_description
       row :goal
       row "Total raised" do |resource|
        total
       end
       row "Largest contribution" do #|resource|
        resource.contributions.maximum(:amount)
       end
       row "Smallest contribution" do |resource|
        resource.contributions.minimum(:amount)
       end
       row "% of goal" do |resource|
        "#{(total.to_f / resource.goal) * 100 } %"
       end
       if resource.landscape_image
         row :landscape_image do |ad|
            image_tag ad.landscape_image.url, class: 'landscape'
         end
       end
       if resource.thumbnail_image
         row :thumbnail_image do |ad|
            image_tag ad.thumbnail_image.url, class: 'thumb'
         end
      end
     end
     active_admin_comments
   end

end
