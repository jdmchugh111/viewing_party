class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])

    if params[:title] != nil
      title = params[:title]
      conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
        faraday.params[:api_key] = Rails.application.credentials.tmdb[:key]
      end
      response = conn.get("/3/search/movie?query=#{title}")
      data = JSON.parse(response.body, symbolize_names: true)
      @movie_list = data[:results].first(20)
    else
      conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
        faraday.params[:api_key] = Rails.application.credentials.tmdb[:key]
      end
      response = conn.get("/3/movie/top_rated")
      data = JSON.parse(response.body, symbolize_names: true)
      @movie_list = data[:results].first(20)
    end
  end
end