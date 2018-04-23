class SearchController < ApplicationController
  
  def es_search
    s = EsSearch.new
    if params[:q]
      body = s.build_body(params)
      @results = s.search(body)
      render 'results'
    else
      render json: {errors: "no search query supplied"}
    end
  end
end
