# TO DO: create tests for the create user transaction.
require 'rails_helper'

RSpec.describe User::CreateUserTransaction do
  context 'CreateUserTransaction creates User and sends email.' do
    let(:user) { build(:user) }
    it 'should create a valid user' do
      # I may need to pass in just the attributes of the FactoryBot user.
      expect(User::CreateUserTransaction.call(user)).be_instance_of(User)
    end
  end
end
