class CreateEventsBatches < ActiveRecord::Migration[5.1]
  def change
    create_table :events_batches do |t|
      t.boolean :delivered, default: false

      t.timestamps
    end
  end
end
