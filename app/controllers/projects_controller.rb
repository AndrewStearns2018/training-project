class ProjectsController < ApplicationController
  def index
    @projects = Project.user_accessible
  end

  def show
    @project = Project.find(params[:id])
  end
end
