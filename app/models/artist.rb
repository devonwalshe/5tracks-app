class Artist < ApplicationRecord
  # Set Tablename
  self.table_name = "artist"
  
  
  # Aliases
  alias_attribute :aliases, :artist_aliases
  alias_attribute :urls, :artist_urls
  alias_attribute :name_variations, :artist_name_variations
  alias_attribute :tracks, :release_tracks
  
  # relationships
  has_many :artist_aliases
  has_many :artist_urls
  has_many :artist_name_variations
  has_and_belongs_to_many :members, class_name: "Artist", join_table: :group_member, foreign_key: :group_artist_id, association_foreign_key: :member_artist_id
  has_and_belongs_to_many :groups, class_name: "Artist", join_table: :group_member, foreign_key: :member_artist_id, association_foreign_key: :group_artist_id
  has_many :release_artists
  has_many :releases, -> { distinct }, through: :release_artists
  has_many :release_labels, through: :releases
  has_many :labels, -> { distinct }, through: :release_labels
  has_many :release_track_artists
  has_many :release_tracks, -> {distinct}, through: :release_track_artists
  
  
  ### Class Methods
  def self.label_id(label_id)
    return Label.find(label_id)
    
  end
  
  ### Instance Methods
  def user_queue_diff(current_user)
    
    artist_tracks = self.main_tracks
    qts = QueueTrack.where(release_track_id: artist_tracks.map{|at| at.id}, user_id: current_user.id)
    diff_tracks_ids = artist_tracks.map{|at| at.id} - qts.map{|qt| qt.release_track_id}
    return {qts: qts, artist_tracks: artist_tracks, diff: artist_tracks.count - qts.count, diff_tracks_ids: diff_tracks_ids}
  end
  
  def main_tracks
    ReleaseTrack.joins(:release_artists => :artist, :release_track_artists => :artist).where('artist.id': self.id, 'release_artist.extra':0, 'release_track_artist.extra': false).uniq
  end
  
  def supporting_tracks
    ReleaseTrack.joins(:release => {:release_artists => {:artist => :release_track_artists}}).where('artist.id': self.id, 'release_artist.extra':1, 'release_track_artist.extra': 't').uniq
  end

  def all_tracks
    release_tracks = ReleaseTrack.includes(:release_artists).where('release_artist.artist_id': self.id, 'release_artist.extra': 0)
    not_tracks = release_tracks.includes(:release_track_artists).where.not('release_track_artist.artist_id': self.id, 'release_track_artist.extra': false)
    tracks = ReleaseTrack.includes(:release_track_artists).where('release_track_artist.artist_id': self.id, 'release_track_artist.extra': false)
    return ((release_tracks + tracks) - not_tracks)
  end

  def release_count
    self.releases.count
  end
  
  def stats
    years = []
    dates = []
    Artist.first.releases.map(&:released).each do |date|
      years << /\d{4}/.match(date)[0]
      matches = date.scan(/\d+/)
      if matches.length > 1
        dates << DateTime.strptime(date, "%Y-%m")
      end
    end
    release_counts = years.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
    # last_active = dates.max
    return {'releases': release_counts}
  end
end
