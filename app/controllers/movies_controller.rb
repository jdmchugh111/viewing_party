class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @facade = DiscoverFacade.new
    
    if params[:title] != nil && params[:title] != ''
      @movie_list = @facade.search_result(params[:title])
    elsif params[:title] == ''
      flash.notice = "Search field cannot be empty"
      redirect_to user_discover_index_path(@user)
    else
      @movie_list = @facade.top_twenty
    end
  end

  def show
    @user_id = params[:user_id]
    @movie_id = params[:id]
    facade = MoviesFacade.new(params[:id])
    @movie = facade.movie
  end
end