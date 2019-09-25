require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validates User model' do
    let(:user) { build(:user) }
    it 'should save a valid user' do
      expect(user.save).to eq true
    end

    it 'should not save a user without first_name' do
      user.first_name = nil
      expect(user.save).to eq false
    end

    it 'should not save a user without last_name' do
      user.last_name = nil
      expect(user.save).to eq false
    end

    it 'should should not save user without date_of_birth' do
      user.date_of_birth = nil
      expect(user.save).to eq false
    end
  end
end
