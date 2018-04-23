class LabelsController < ApplicationController

  def show
    @label = Label.find(params[:id])
    @artists = @label.artists.order(:name).page params[:artists_page]
    @releases = @label.releases.order(:released).page params[:releases_page]
    respond_to do |format|
      format.js
      format.html
    end
  end
  
end
