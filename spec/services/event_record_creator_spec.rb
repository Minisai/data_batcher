require 'rails_helper'

RSpec.describe EventRecordCreator do
  let(:service) { EventRecordCreator.new(attributes) }

  context 'successful record creation' do
    let(:attributes) { { value: 'event1' } }

    it 'returns valid EventRecord' do
      expect(AvailableBatchPusher).to receive_message_chain(:new, :push_event)
      expect(service.create).to be_valid
    end
  end

  context 'failed record creation' do
    let(:attributes) { { value: nil } }

    it 'does not call AvailableBatchPusher' do
      expect(AvailableBatchPusher).not_to receive(:new)
      expect do
        service.create
      end.not_to change(EventRecord, :count)
    end
  end
end
