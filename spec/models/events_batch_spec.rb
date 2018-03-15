require 'rails_helper'

RSpec.describe EventsBatch, type: :model do
  context 'factories' do
    it 'is valid' do
      expect(FactoryBot.build(:events_batch)).to be_valid
    end
  end
end
