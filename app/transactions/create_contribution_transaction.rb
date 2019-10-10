require "dry/transaction"

class CreateContributionTransaction
  include Dry::Transaction

  tee :params
  step :reward_valid
  step :create_contribution
  tee :update_reward


  private

  def params(input)
    @contribution = input[:contribution]
  end

  def reward_valid(_input)
    # If there is a reward do => else send success
    if @contribution.reward.nil?
      Success(@contribution)
    else
      @reward = Reward.find(@contribution[:reward_id])
      if @reward.units - (@contribution[:amount].to_i / @reward.price) > 0
        if @reward.price <= @contribution[:amount].to_i
          Success(@contribution)
        else
          Failure(error: "Your contribution is not enough for this reward.")
        end
      else
        Failure(error: "There are not enough units left.")
      end
    end
  end

  def create_contribution(_input)
    if @contribution.save
      Success(@contribution)
    else
      Failure(error: @contribution.errors.full_messages)
    end
  end

  def update_reward(_input)
    if @reward
      @reward.units -= @contribution[:amount].to_i / @reward.price.to_i
      @reward.save
    end
  end
end
