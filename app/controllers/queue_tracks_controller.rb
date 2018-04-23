class QueueTracksController < ApplicationController
  
  def enqueue
    @tracks = ReleaseTrack.where(id: params[:ids])
    @tracks.each do |t|
      qt = QueueTrack.new()
      qt.user = current_user
      qt.release = t.release
      qt.release_track = t
      qt.queue = params[:queue]
      qt.save
    end
      
    if params[:context] == "tracklist"
      @tracks = Release.find(params[:parent_id]).release_tracks
      respond_to do |format|
        format.js { render "components/track_list/track_list.js.html.haml"}
      end
    elsif params[:context] == "artist"
      @qt_diff = Artist.find(params[:parent_id]).user_queue_diff(current_user)
      @context = params[:context]
      @parent_id = params[:parent_id]
      render html: helpers.component('enqueue_button')
    end
  end

end
