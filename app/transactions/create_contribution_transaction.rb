require "dry/transaction"

class CreateContributionTransaction
  include Dry::Transaction

  tee :params
  step :reward_valid
  step :create_contribution
  step :create_card_web_payin

  private

  def params(input)
    @contribution = input[:contribution]
  end

  def reward_valid(_input)
    if @contribution.reward
      @reward = @contribution.reward
      if @reward.units - (@contribution[:amount].to_i / @reward.price) > 0
        if @reward.price <= @contribution[:amount].to_i
          Success(@contribution)
        else
          Failure(@contribution.errors.add(:amount, "- your contribution is not enough for this reward."))
        end
      else
        Failure(@contribution.errors.add(:amount, "- there are not enough units left."))
      end
    else
      Success(@contribution)
    end
  end

  def create_contribution(_input)
    if @contribution.save
      Success(@contribution)
    else
      Failure(@contribution.errors.full_messages)
    end
  end

  def create_card_web_payin(input)
    @card_pay_in = MangoPay::PayIn::Card::Web.create(payin_params)
    if MangoPay::PayIn.fetch(@card_pay_in["Id"])
      @contribution.update(pay_in_id: @card_pay_in["Id"])
      Success(@card_pay_in)
    else
      Failure(@contribution)
    end
  end

  def payin_params
    {
    "AuthorId": @contribution.user.mango_user_id,
    "CreditedUserId": @contribution.project.user.mango_user_id,
    "DebitedFunds": {
    "Currency": "EUR",
    "Amount": @contribution.amount * 100
    },
    "Fees": {
    "Currency": "EUR",
    "Amount": 0
    },
    "ReturnURL": "http://localhost:3000/projects/#{@contribution.project.id}/contributions/#{@contribution.id}/verify_payment",
    "CardType": "CB_VISA_MASTERCARD",
    "CreditedWalletId": @contribution.project.user.mango_wallet_id,
    "Culture": "EN"
    }
  end
end
