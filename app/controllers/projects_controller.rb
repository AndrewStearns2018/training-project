class ProjectsController < ApplicationController
  def index
    @projects = Project.user_accessible
  end

  def show
    if admin_user_signed_in?
      @project = Project.find(params[:id])
    else
      @project = Project.user_accessible.find(params[:id])
    end
  end
end
