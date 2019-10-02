class ProjectsController < ApplicationController
  def index
    @projects = Project.user_accessible
  end
end
