require 'rails_helper'
RSpec.describe(CreateRewardTransaction) do
  context 'Event to change Project state is fired when Reward is created' do
    let(:reward) { build(:reward) }
    let(:project) { build(:project) }
    let(:user) { build(:user) }
    subject { CreateProjectTransaction.new.call(project: project) }

    before do
      project.user = user
    end

    it 'should update from upcoming to ongoing if fields are complete' do
      reward.project = subject.success
      expect(CreateRewardTransaction.new.call(reward: reward).success.project).to have_state(:ongoing)
    end

    it 'should still be in draft if the fields are not all filled in' do
      project.short_description = nil
      reward.project = subject.success
      expect(CreateRewardTransaction.new.call(reward: reward).success.project).to have_state(:draft)
    end
  end
end
