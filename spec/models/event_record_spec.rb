require 'rails_helper'

RSpec.describe EventRecord, type: :model do
  context 'factories' do
    it 'is valid' do
      expect(FactoryBot.build(:event_record)).to be_valid
    end
  end
end
