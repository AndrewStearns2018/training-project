require 'rails_helper'
RSpec.describe CreateContributionTransaction do
  context 'Validates contributions transaction' do
    let(:contribution) { build(:contribution) }
    let(:reward) { build(:reward) }
    let(:user) { build(:user) }
    let(:project) { build(:project) }

    subject { CreateContributionTransaction.new.call(contribution: contribution) }

    before do
      contribution.reward = reward
      contribution.user = CreateUserTransaction.new.call(user_params: user)
      contribution.project = CreateProjectTransaction.new.call(project: project)
      VCR.insert_cassette('transactions/create_contribution_transaction')
    end

    it 'should create an instance of contribution' do
      binding.pry
      expect(subject.success).to be_instance_of(Contribution)
    end

    it 'should create a MangoPay payin' do
      puts subject.success
    end


    it 'should create contribution without reward' do
      contribution.reward = nil
      expect(subject.success).to be_instance_of(Contribution)
    end

    after do
      VCR.eject_cassette('transactions/create_contribution_transaction')
    end
    # These tests will be used in the verify payment transactioin

    # it 'should deduct units' do
    #   units_bought = contribution.amount / reward.price
    #   expect(subject.success.reward.units - units_bought).to eq reward.reload.units
    # end

    # it 'should not let you buy more units than exist' do
    #   amount = reward.price * reward.units + 1
    #   contribution.amount = amount
    #   expect(subject).to be_failure
    # end
  end
end
