ActiveAdmin.register Reward do
  belongs_to :project
  permit_params :name, :price, :units

  controller do
    def create
      reward = Reward.new(permitted_params[:reward])
      project = Project.find(params[:project_id])
      reward.project = project
      CreateRewardTransaction.new.call(reward: reward) do |m|
        m.success do |s|
          redirect_to admin_project_path(s.project)
        end
        m.failure do |f|
          @reward = Reward.new(permitted_params[:reward])
          @project = Project.find(params[:project_id])
          @reward.project = @project
          render :new
        end
      end
    end

    def update
      update! do |format|
        format.html { redirect_to admin_project_path(resource.project) } if resource.valid?
      end
    end

    def destroy
      if resource.project.aasm_state == 'draft' || resource.project.aasm_state == 'upcoming'
        destroy! do |format|
          format.html { redirect_to admin_project_path(resource.project) }
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :units
    end
    f.actions
  end
end
