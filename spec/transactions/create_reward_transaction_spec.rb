require 'rails_helper'
RSpec.describe(CreateRewardTransaction) do
  context 'Event to change Project state is fired when Reward is created' do
    let(:project) { build(:project) }
    let(:reward) { build(:reward) }
    subject { CreateProjectTransaction.new.call(project: project) }

    it 'should update from upcoming to ongoing if fields are complete' do
      reward.project = subject.success[:project]
      expect(CreateRewardTransaction.new.call(reward: reward).success[:reward].project).to have_state(:ongoing)
    end

    it 'should still be in draft if the fields are not all filled in' do
      project.short_description = nil
      reward.project = subject.success[:project]
      expect(CreateRewardTransaction.new.call(reward: reward).success[:reward].project).to have_state(:draft)
    end
  end
end
