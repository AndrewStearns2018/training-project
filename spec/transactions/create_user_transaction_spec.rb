require 'rails_helper'

RSpec.describe CreateUserTransaction do
  describe 'Mango user creation' do
    context 'CreateUserTransaction creates User and sends email.' do
      let(:user) { build(:user) }

      context 'success' do
      subject { CreateUserTransaction.new.call(user: user) }

        before do
          VCR.insert_cassette('transactions/create_user_transaction')
        end

        it 'should create a new mango user' do
          expect(subject.success.mango_user_id).to_not be(nil)
        end

        it 'should create user wallet' do
          expect(subject.success.mango_wallet_id).to_not be(nil)
        end

        it 'should return success' do
          expect(subject.success).to be_an_instance_of(User)
        end

        it 'should send a welcome email' do
          expect { subject }.to change { ActionMailer::Base.deliveries.count }
        end

        after do
          VCR.eject_cassette('transactions/create_user_transaction')
        end
      end
    end
  end
end

