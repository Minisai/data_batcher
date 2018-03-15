require 'rails_helper'

RSpec.describe EventsBatchSender do
  let(:events_batch) { FactoryBot.create(:events_batch) }
  let(:service) { EventsBatchSender.new(events_batch) }

  before do
    FactoryBot.create(:event_record, events_batch: events_batch, value: 'event1')
    FactoryBot.create(:event_record, events_batch: events_batch, value: 'event2')
    FactoryBot.create(:event_record, events_batch: events_batch, value: 'event3')
  end

  context 'send_batch' do
    it 'sends expected data via RestClient' do
      expect(RestClient).to receive(:post).with(ENV['CONSUMER_URL'], %w(event1 event2 event3))
      service.send_batch
    end
  end
end
