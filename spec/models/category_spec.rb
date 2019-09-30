require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'Validates Category model' do
    let(:category) { build(:category) }
    it 'should create a valid category with name' do
      expect(category.save).to eq true
    end

    it 'should not create category without a name' do
      category.name = nil
      expect(category.save).to eq false
    end
  end
end
