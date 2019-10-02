require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'Validates Project model' do
    let(:project) { build(:project) }
    it 'should create a valid project.' do
      expect(project.save).to eq true
    end

    it 'should not create a project without a name' do
      project.name = nil
      expect(project.save).to eq false
    end

    it 'should not create a project without a goal' do
      project.goal = nil
      expect(project.save).to eq false
    end

    it 'should not create a project with a float goal' do
      project.goal = 100.5
      expect(project.save).to eq false
    end

    it 'should not create a project with a string goal' do
      project.goal = "string"
      expect(project.save).to eq false
    end
  end

  context 'Validates state transitions' do
    let(:project) { build(:project) }
    it 'initial state should be :draft' do
      project.short_description = nil
      expect(project).to have_state(:draft)
    end
  end
end
