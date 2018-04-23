class ArtistsController < ApplicationController
  protect_from_forgery except: :show
  
  def show
    @artist = Artist.find(params[:id])
    @releases = @artist.releases.page params[:releases_page]
    @qt_diff = @artist.user_queue_diff(current_user)
    respond_to do |format|
      format.js { render 'artists/show', locals: {releasesPage: params[:releases_page]}}
      format.html 
    end

    
  end
  
  def artist_labels_list
    @artist = Artist.find(params[:artist_id])
    @labels = @artist.labels.sort {|a,b| a.artist_releases(@artist.id).count <=> b.artist_releases(@artist.id).count}.reverse
    @labels = Kaminari.paginate_array(@labels).page params[:labels_page]
    respond_to do |format|
      format.js {render 'components/labels_list/labels_list', locals: {labelsPage: params[:labels_page]}}
      format.html {render partial: 'components/labels_list/labels_list'}
    end
    # render partial: 'components/labels_list/labels_list'
  end 

end
