require 'rails_helper'

RSpec.describe AvailableBatchPusher do
  let(:service) { AvailableBatchPusher.new }

  let(:event_record) { FactoryBot.build(:event_record) }

  context 'events_batch is not full' do
    context 'batch was already created' do
      let!(:events_batch) { FactoryBot.create(:events_batch) }

      it 'pushes event_record to existed batch' do
        expect do
          service.push_event(event_record)
        end.not_to change { EventsBatch.count }
        expect(events_batch.event_records.to_a).to eq [event_record]
      end

      it 'does not enqueue EventsBatchSendingJob' do
        expect do
          service.push_event(event_record)
        end.not_to have_enqueued_job(EventsBatchSendingJob)
      end
    end

    context 'new batch is going to be created' do
      it 'creates new batch' do
        expect do
          service.push_event(event_record)
        end.to change { EventsBatch.count }.from(0).to(1)
        expect(EventsBatch.last.event_records.to_a).to eq [event_record]
      end
    end
  end

  context 'events_batch is full' do
    let!(:events_batch) { FactoryBot.create(:events_batch) }
    before do
      9.times do
        service.push_event(FactoryBot.build(:event_record))
      end
    end

    it 'enqueues EventsBatchSendingJob' do
      expect do
        service.push_event(FactoryBot.build(:event_record))
      end.to have_enqueued_job(EventsBatchSendingJob).with(events_batch.id)
    end
  end
end
