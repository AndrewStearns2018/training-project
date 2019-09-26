# TO DO: create tests for the create user transaction.
require 'rails_helper'

RSpec.describe CreateUserTransaction do
  context 'CreateUserTransaction creates User and sends email.' do
    let(:user) { attributes_for(:user) }
    subject { CreateUserTransaction.new.call(user_params: user) }
    it 'should return success' do
      expect(subject).to be_success
    end

    it 'should create a valid user' do
      expect(subject.success[:user]).to be_an_instance_of(User)
    end

    it 'should send a welcome email' do
      expect { subject }.to change { ActionMailer::Base.deliveries.count }
    end

    it 'should not create a user without first_name.' do
      user[:first_name] = nil
      expect(subject).to be_failure
    end

    it 'should not create a user without last_name' do
      user[:last_name] = nil
      expect(subject).to be_failure
    end

    it 'should not create a user without date_of_birth' do
      user[:date_of_birth] = nil
      expect(subject).to be_failure
    end
  end
end

