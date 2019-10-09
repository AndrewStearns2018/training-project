class ProjectsController < ApplicationController
  def index
    @q = Project.ransack(params[:q])
    @projects = @q.result.user_accessible.includes(:category)
  end

  def show
    if admin_user_signed_in?
      @project = Project.find(params[:id])
    else
      @project = Project.user_accessible.find(params[:id])
    end
  end
end
