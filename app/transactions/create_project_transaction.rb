require "dry/transaction"

class CreateProjectTransaction
  include Dry::Transaction

  tee :params
  tee :upcoming
  #tee :ongoing
  step :create!

  private

  def params(input)
    @project = input[:project]
  end

  def upcoming(_input)

    if @project.may_fields_complete?
      @project.fields_complete
    end
  end

# This logic needs to be in a different transaction.
# The ONLY way to go from upcoming to ongoing is to call has_reward
# when the reward is created.

  # def ongoing(_input)
  #   if @project.may_has_reward?
  #     @project.has_reward
  #   end
  # end

  def create!(input)
    if @project.save
      Success(@project)
    else
      Failure(error: @project.errors.full_messages)
    end
  end
end
