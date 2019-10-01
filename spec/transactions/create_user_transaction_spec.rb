# TO DO: create tests for the create user transaction.
require 'rails_helper'

RSpec.describe CreateUserTransaction do
  context 'CreateUserTransaction creates User and sends email.' do
    let(:user) { attributes_for(:user) }
    it 'should create a valid user and send email' do
      expect(CreateUserTransaction.new.call(user_params: user)).to be_success
    end

    it 'should not create a user without first_name.' do
      user[:first_name] = nil
      expect(CreateUserTransaction.new.call(user_params: user)).to be_failure
    end

    it 'should not create a user without last_name' do
      user[:last_name] = nil
      expect(CreateUserTransaction.new.call(user_params: user)).to be_failure
    end

    it 'should not create a user without date_of_birth' do
      user[:date_of_birth] = nil
      expect(CreateUserTransaction.new.call(user_params: user)).to be_failure
    end
  end
end

