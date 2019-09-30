ActiveAdmin.register Reward do
  belongs_to :project
  permit_params :name, :price, :units

  controller do
    def create
      create! do |format|
        format.html { redirect_to admin_project_path(resource.project) } if resource.valid?
      end
    end

    def update
      update! do |format|
        format.html { redirect_to admin_project_path(resource.project) } if resource.valid?
      end
    end

    def destroy
      destroy! do |format|
        format.html { redirect_to admin_project_path(resource.project) }
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
