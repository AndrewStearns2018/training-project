class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def home
  end

  def dashboard
    @user = current_user
    @contributions = @user.contributions.success
    @total_projects = @user.contributions.success.select(:project_id).distinct.count
  end
end
