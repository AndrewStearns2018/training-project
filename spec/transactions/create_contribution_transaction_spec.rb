require 'rails_helper'
RSpec.describe CreateContributionTransaction do
  context 'Validates contributions transaction' do
    let(:project_owner) { create(:project_owner) }
    let(:contributor) { create(:contributor) }
    let(:project) { create(:project, user: project_owner) }
    let(:reward) { create(:reward, project: project) }

    let(:contribution) { build(:contribution, reward: reward, project: project, user: contributor) }

    subject { CreateContributionTransaction.new.call(contribution: contribution) }

    before do
      VCR.insert_cassette('transactions/create_contribution_transaction')
    end

    it 'should be success' do
      expect(subject).to be_success
    end

    it 'should create a MangoPay payin' do
      expect(subject.success["Id"]).to_not be(nil)
    end


    it 'should be success without reward' do
      contribution.reward = nil
      expect(subject).to be_success
    end
    context 'Refuse contribution is there are not enough reward units' do
      before do
        amount = reward.price * reward.units + 1
        contribution.amount = amount
      end
      it 'should not let you buy more units than exist' do
        expect(subject).to be_failure
      end
    end
    after do
      VCR.eject_cassette('transactions/create_contribution_transaction')
    end
  end
end
