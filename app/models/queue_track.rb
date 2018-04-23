class QueueTrack < ApplicationRecord
  # Callbacks
  # after_save :get_ratings
  
  # Validations
  
  # Relationships
  belongs_to :release_track
  belongs_to :release
  belongs_to :user
  
  # Instance Methods
  def artists
    Artist.joins(:releases => {:release_artists => {:release_tracks => :release_track_artists}}).where("release_track.id": self.release_track_id, "release_artist.extra": 0, 'release_track_artist.extra': false)
  end
  
  def main_release_artists
    Artist.where()
  end
  
  private
  
  def get_ratings()
    return true
    # Do some crazy async shit with active job to pull ratings for queue tracks
  end
  
  
end
