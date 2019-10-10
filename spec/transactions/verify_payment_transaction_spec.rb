require 'rails_helper'
RSpec.describe VerifyPaymentTransaction do
  context 'Valid payments are approved' do
    let(:project_owner) { create(:project_owner) }
    let(:contributor) { create(:contributor) }
    let(:project) { create(:project, user: project_owner) }
    let(:reward) { create(:reward, project: project) }

    let(:paid_contribution) { create(:paid_contribution, reward: reward, project: project, user: contributor) }

    subject { VerifyPaymentTransaction.new.call(contribution: paid_contribution) }

    before do
      VCR.insert_cassette('transactions/verify_payment_transaction')
    end

    it 'should update the state of contribution' do
      expect(subject.success.aasm_state).to eq('success')
    end

    it 'should deduct units' do
      expect { subject.success.reward.units }.to change { reward.units }
    end

    after do
      VCR.eject_cassette('transactions/verify_payment_transaction')
    end
  end
  context 'Invalid payments are denied' do
    let(:project_owner) { create(:project_owner) }
    let(:contributor) { create(:contributor) }
    let(:project) { create(:project, user: project_owner) }
    let(:reward) { create(:reward, project: project) }

    let(:unpaid_contribution) { create(:unpaid_contribution, reward: reward, project: project, user: contributor) }

    subject { VerifyPaymentTransaction.new.call(contribution: unpaid_contribution) }

    before do
      VCR.insert_cassette('transactions/verify_payment_transaction_unpaid')
    end

    it 'should update the state of contribution' do
      expect(subject.failure.aasm_state).to eq('pending')
    end

    it 'should not deduct units' do
      expect { subject.failure.reward.units }.not_to change { reward.units }
    end

    after do
      VCR.eject_cassette('transactions/verify_payment_transaction_unpaid')
    end
  end
end
