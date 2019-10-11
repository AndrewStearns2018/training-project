ActiveAdmin.register Project do
  permit_params :name, :short_description, :long_description, :goal, :category_id, :user_id, :landscape_image, :thumbnail_image

  action_item :new_reward, only: :show do
    link_to "New reward", new_admin_project_reward_path(resource)
  end

  action_item :preview, only: :show do
    link_to "Preview", project_path(resource), target: :_blank
  end

  action_item :success, only: :show do
    if resource.may_trigger_success?
      link_to "Success", success_admin_project_path
    end
  end

  action_item :failure, only: :show do
    if resource.may_trigger_failure?
      link_to "Failure", failure_admin_project_path
    end
  end

  action_item :contributions_csv, only: :show do
    link_to "Download contributions", contributions_csv_admin_project_path, format: :csv, target: :_blank
  end

  member_action :success, method: :get do
    if resource.may_trigger_success?
      resource.trigger_success!
      redirect_to admin_project_path(resource)
    end
  end

  member_action :failure, method: :get do
    if resource.may_trigger_failure?
      resource.trigger_failure!
      redirect_to admin_project_path(resource)
    end
  end

  member_action :contributions_csv, method: :get do
    csv_file = CSV.generate(headers: true) do |csv|
      attributes = %w{id first_name last_name nationality country_of_residence date_of_birth last_sign_in_at}
      csv << attributes
      resource.contributions.each do |contribution|
        csv << attributes.map{ |attr| contribution.user.send(attr) }
      end
    end
    send_data csv_file
  end

  scope :all, default: true
  scope :draft
  scope :upcoming
  scope :ongoing
  scope :success
  scope :failure

  index do
    selectable_column
    id_column
    column :name
    column :goal
    column :created_at
    column 'status' do |resource|
      resource.aasm_state
    end
    actions
  end

  filter :name
  filter :goal
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :category
      f.input :user, member_label: Proc.new { |c| "#{c.first_name} #{c.last_name}" }
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
          @project = Project.new(permitted_params[:project])
          render :new
        end
      end
    end

    def update
    resource.assign_attributes(permitted_params[:project])
      CreateProjectTransaction.new.call(project: resource) do |m|
        m.success do |s|
          redirect_to admin_project_path(s)
        end
        m.failure do |f|
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
       row "Status" do |resource|
        resource.aasm_state
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
        column :name
        column :price
        column :units
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
