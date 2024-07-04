class MoviesFacade
  def initialize(movie_id)
    @movie_id = movie_id
  end

  def movie
    service = MovieService.new(@movie_id)

    info = service.info
    credits = service.credits
    reviews = service.reviews
    providers = service.providers
    similar = service.similar

    Movie.new(info, credits, reviews, providers, similar)
  end
end