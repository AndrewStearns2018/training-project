require 'rails_helper'
RSpec.describe CreateProjectTransaction do
  context 'CreateProjectTransaction creates project and updates state' do
    let(:project) { build(:project) }
    let (:reward) { build(:reward) }
    subject { CreateProjectTransaction.new.call(project: project) }

    it 'should create project' do
      expect(subject.success).to be_an_instance_of(Project)
    end

    it 'should have a draft state if there is no short_description' do
      project.short_description = nil
      expect(subject.success).to have_state(:draft)
    end

    it 'should have a draft state if there is no long_description' do
      project.long_description = nil
      expect(subject.success).to have_state(:draft)
    end

    it 'should have a draft state if there is no landscape_image' do
      project.landscape_image_data = nil
      expect(subject.success).to have_state(:draft)
    end

    it 'should have a draft state if there is no thumb_nail_image' do
      project.thumbnail_image_data = nil
      expect(subject.success).to have_state(:draft)
    end

    it 'should have a state of upcoming if all fields are filled' do
      expect(subject.success).to have_state(:upcoming)
    end
  end
end
