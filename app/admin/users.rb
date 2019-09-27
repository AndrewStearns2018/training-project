ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :date_of_birth, :password, :password_confirmation

  action_item :log_in_as, only: :show do
    link_to "Sign in as", log_in_as_admin_user_path
  end

  member_action :log_in_as, method: :get do
    user = User.find(params[:id])
    sign_in user
    redirect_to root_path
  end


  index do
    selectable_column
    id_column
    column :email
    column :last_name
    column :first_name
    column :created_at
    column :updated_at
    column :sign_in_count
    column :last_sign_in_at
    column :last_sign_in_ip
    actions
  end

  filter :email
  filter :last_name
  filter :first_name
  filter :created_at
  filter :last_sign_in_at
  filter :sign_in_count

  form do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :date_of_birth
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
