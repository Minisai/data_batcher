class AddEventRecordsCountToEventsBatch < ActiveRecord::Migration[5.1]
  def change
    add_column :events_batches, :event_records_count, :integer, default: 0
  end
end
