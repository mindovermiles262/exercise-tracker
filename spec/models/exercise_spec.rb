require 'rails_helper'

RSpec.describe Exercise, type: :model do
  before :each do
    @exercise = FactoryGirl.create(:exercise)
  end

  context 'factory' do
    it 'is valid' do
      expect(@exercise).to be_valid
    end
  end
end