class CreateEventRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :event_records do |t|
      t.string :value
      t.integer :events_batch_id, index: true

      t.timestamps
    end
  end
end
