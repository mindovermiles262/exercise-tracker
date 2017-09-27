require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  context 'factory' do
    it 'has a valid user' do
      expect(@user).to be_valid
    end
  end
end