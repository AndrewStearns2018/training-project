require "dry/transaction"

class CreateRewardTransaction
  include Dry::Transaction

  tee :params
  step :create!

  private

  def params(input)
    @reward = input[:reward]
  end

  def create!(input)
    if @reward.save
      if @reward.project.may_has_reward?
        @reward.project.has_reward
      end
      Success(input)
    else
      Failure(@reward.errors.full_messages)
    end
  end
end