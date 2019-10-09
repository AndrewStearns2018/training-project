class AddUserReferenceToProjects < ActiveRecord::Migration[6.0]
  def change
    add_reference(:projects, :user)
  end
end
