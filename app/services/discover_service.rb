class DiscoverService
  def top_rated
    get_url("/3/movie/top_rated")
  end

  def search_title(title)
    get_url("/3/search/movie?query=#{title}")
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