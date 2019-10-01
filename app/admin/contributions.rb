ActiveAdmin.register Contribution do

  index do
    selectable_column
    id
    column "User" do |resource|
      link_to "#{resource.user.first_name} #{resource.user.last_name}", admin_user_path(resource.user)
    end
    column :amount
    column :reward
    column :created_at
  end
end
