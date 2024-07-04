class MovieService
  def initialize(movie_id)
    @movie_id = movie_id
  end

 def info
    get_url("/3/movie/#{@movie_id}")
  end

  def credits 
    get_url("/3/movie/#{@movie_id}/credits")
  end

  def reviews
    get_url("/3/movie/#{@movie_id}/reviews")
  end

  def providers
    get_url("/3/movie/#{@movie_id}/watch/providers")
  end

  def similar
    get_url("/3/movie/#{@movie_id}/similar")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params[:api_key] = Rails.application.credentials.tmdb[:key]
    end
  end

end