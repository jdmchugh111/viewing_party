class SimilarController < ApplicationController
  def index
    facade = MoviesFacade.new(params[:movie_id])
    @movie = facade.movie
  end
end