class ReleaseArtist < ApplicationRecord
  # Set Tablename
  self.table_name = "release_artist"
  
  # Relationships
  belongs_to :release
  belongs_to :artist
  has_many :release_tracks, through: :release
end
