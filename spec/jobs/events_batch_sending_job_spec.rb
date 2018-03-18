require 'rails_helper'

RSpec.describe EventsBatchSendingJob, type: :job do
  include ActiveJob::TestHelper

  let(:event_batch_id) { 456_789 }
  let(:job) { described_class.perform_later(event_batch_id) }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).from(0).to(1)
  end

  context 'events_batch not delivered' do
    let!(:events_batch) { FactoryBot.create(:events_batch, id: event_batch_id, delivered: false) }

    it 'does call EventsBatchSender' do
      perform_enqueued_jobs do
        expect(EventsBatchSender).to receive_message_chain(new: events_batch, send_batch: nil)
        job
        expect(events_batch.reload.delivered).to eq true
      end
    end
  end

  context 'events_batch already delivered' do
    let!(:event_batch) { FactoryBot.create(:events_batch, id: event_batch_id, delivered: true) }

    it 'does not call EventsBatchSender' do
      perform_enqueued_jobs do
        expect(EventsBatchSender).not_to receive(:new)
        job
      end
    end
  end
end
