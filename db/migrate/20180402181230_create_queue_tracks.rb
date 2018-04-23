class CreateQueueTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :queue_tracks do |t|
      t.integer :user_id
      t.integer :release_track_id
      t.integer :release_id
      t.string :queue
      t.boolean :in_library
      t.integer :popularity_rating
      t.integer :underground_rating
      t.integer :similarity_rating
      t.integer :total_rating
      t.timestamps
    end
  end
end
