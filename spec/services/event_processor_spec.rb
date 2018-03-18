require 'rails_helper'

RSpec.describe EventProcessor do
  let(:service) { EventProcessor.new(event) }

  context 'successful record creation' do
    let(:event) { 'event1' }

    it 'returns valid EventRecord' do
      expect(AvailableBatchPusher).to receive_message_chain(:new, :push_event)
      expect(service.process).to be_truthy
    end
  end

  context 'failed record creation' do
    let(:event) { nil }

    it 'does not call AvailableBatchPusher' do
      expect(AvailableBatchPusher).not_to receive(:new)
      expect do
        service.process
      end.not_to change(EventRecord, :count)
    end

    it 'returns false' do
      expect(service.process).to be_falsey
    end
  end
end
