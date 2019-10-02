ActiveAdmin.register Project do
  permit_params :name, :short_description, :long_description, :goal, :category_id, :landscape_image, :thumbnail_image

  action_item :new_reward, only: :show do
    link_to "New reward", new_admin_project_reward_path(resource)
  end

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

  controller do
    def create
      project = Project.new(permitted_params[:project])
      CreateProjectTransaction.new.call(project: project) do |m|
        m.success do |s|
          redirect_to admin_project_path(s)
        end
        m.failure do |f|
          # If I want the errors to show, I need to get into the AA errors
          # @errors = f[:error]
          @project = Project.new(permitted_params[:project])
          render :new
        end
      end
    end

    def update
      #raise
      # I'm really not sure on what to pass in here so that an instance
      # of Project is passed into my transaction in the same way that Project.new
      # passed in an instance of project.
      project = resource.update_attributes(permitted_params[:project])
      CreateProjectTransaction.new.call(project: project) do |m|
        m.success do |s|
          redirect_to admin_project_path(s)
        end
        m.failure do |f|
          @project = resource
          render :edit
        end
      end
    end
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

     link_to "Add new reward", new_admin_project_reward_path(resource), class: 'action_item'

     if resource.rewards
       table_for resource.rewards do |reward|
        column "Name", :name
        column "Price", :price
        column "Units left", :units
        column("") do |reward|
          span link_to "Edit", edit_admin_project_reward_path(reward.project, reward)
          span link_to "Delete", admin_project_reward_path(reward.project, reward),
          method: :delete,
          data: { confirm: 'Are you sure you want to delete this?' }
        end
       end
     end
     active_admin_comments

   end

end
