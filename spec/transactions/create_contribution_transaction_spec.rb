require 'rails_helper'
RSpec.describe CreateContributionTransaction do
  context 'Validates contributions transaction' do
    let(:reward) { create(:reward) }
    let(:contribution) { build(:contribution) }

    before do
      contribution.reward = reward
    end

    subject { CreateContributionTransaction.new.call(contribution: contribution) }

    it 'should create an instance of contribution' do
      expect(subject.success).to be_instance_of(Contribution)
    end

    it 'should deduct units' do
      units_bought = contribution.amount / reward.price
      expect(subject.success.reward.units - units_bought).to eq reward.reload.units
    end

    it 'should not let you buy more units than exist' do
      amount = reward.price * reward.units + 1
      contribution.amount = amount
      expect(subject).to be_failure
    end

    it 'should create contribution without reward' do
      contribution.reward = nil
      expect(subject.success).to be_instance_of(Contribution)
    end
  end
end
