class ContributionsController < ApplicationController
  def new
    if current_user
      @contribution = Contribution.new
      @project = Project.find(params[:project_id])
    else
      redirect_to new_user_session_path
    end
  end

  def create
    contribution = Contribution.new(contribution_params)
    contribution.user = current_user
    contribution.project = Project.find(params[:project_id])
    unless params[:contribution][:reward].empty?
      contribution.reward = Reward.find(params[:contribution][:reward])
    end
    CreateContributionTransaction.new.call(contribution: contribution) do |m|
      m.success do |s|
        redirect_to s["RedirectURL"]
      end
      m.failure do |f|
        @contribution = Contribution.new
        @project = Project.find(params[:project_id])
        render :new
      end
    end
  end

  def verify_payment
    contribution = Contribution.find(params[:id])
    VerifyPaymentTransaction.new.call(contribution: contribution) do |m|
      m.success do |s|
        redirect_to project_path(s.project)
      end
      m.failure do |f|
        @contribution = Contribution.new
        @project = Project.find(f.project.id)
        render :new
      end
    end
  end

  private

  def contribution_params
    params.require(:contribution).permit(:amount)
  end
end