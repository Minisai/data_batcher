class CreateEventRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :event_records do |t|
      t.string :value
      t.boolean :delivered, default: false

      t.timestamps
    end
  end
end
