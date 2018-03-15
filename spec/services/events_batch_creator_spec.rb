require 'rails_helper'

RSpec.describe EventsBatchCreator do
  let(:service) { EventsBatchCreator.new }
  let(:events_batch) { FactoryBot.build(:events_batch) }

  before do
    allow(EventsBatch).to receive(:new).and_return(events_batch)
  end

  context 'successful record creation' do
    it 'creates a new EventsBatch record' do
      expect do
        service.create
      end.to change(EventsBatch, :count).by(1)
    end

    it 'schedules EventsBatchSendingJob' do
      expect do
        service.create
      end.to have_enqueued_job(EventsBatchSendingJob).with(events_batch.id).on_queue('default')
    end
  end

  context 'failed record creation' do
    before do
      expect(events_batch).to receive(:save).and_return(false)
    end

    it 'does not schedule EventsBatchSendingJob' do
      expect do
        service.create
      end.not_to have_enqueued_job(EventsBatchSendingJob)
    end
  end
end
