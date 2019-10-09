require "dry/transaction"

class VerifyPaymentTransaction
  include Dry::Transaction

  tee :params
  step :update_contribution_state
  step :update_reward

  private

  def params(input)
    @contribution = input[:contribution]
  end

  def update_contribution_state(_input)
    if @contribution.may_payment_accepted?
      @contribution.payment_accepted!
      Success(@contribution)
    else
      Failure(@contribution)
    end
  end

  def update_reward(_input)
    if @contribution.reward
      reward = @contribution.reward
      reward.units -= @contribution[:amount].to_i / reward.price.to_i
      if reward.save
        Success(@contribution)
      else
        Failure(@contribution)
      end
    else
      Success(@contribution)
    end
  end
end
