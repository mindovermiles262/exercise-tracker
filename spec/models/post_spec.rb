require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @post = FactoryGirl.create(:post)
  end

  context 'factory' do
    it 'is valid' do
      expect(@post).to be_valid
    end
  end
end