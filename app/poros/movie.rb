class Movie
  attr_reader :title,
              :vote_average,
              :runtime,
              :runtime_hrs,
              :genre,
              :summary,
              :cast,
              :reviews,
              :id,
              :for_rent,
              :for_sale,
              :similar_movies

  def initialize(info, credits, reviews, providers, similar)
    @title = info[:title]
    @vote_average = info[:vote_average]
    @runtime = info[:runtime]
    @runtime_hrs = runtime_hm(info[:runtime])
    @genre = genre_list(info[:genres])
    @summary = info[:overview]
    @credits = credits
    @cast = cast_list(@credits)
    @reviews = review_objects(reviews)
    @for_rent = providers[:results][:US][:rent]
    @for_sale = providers[:results][:US][:buy]
    @similar_movies = similar[:results]
  end

  def runtime_hm(runtime)
    hours = runtime / 60
    minutes = runtime % 60
    "#{hours} hours, #{minutes} minutes"
  end

  def genre_list(genres)
    genres_array = []
    genres.each do |genre|
      genres_array << genre[:name]
    end
    genres_array.to_sentence
  end

  def cast_list(credits_hash)
    credits_hash[:cast].first(10).map do |actor|
      actor[:name]
    end.to_sentence
  end

  def review_objects(review_hash)
    review_hash[:results].map do |review|
      Review.new(review)
    end
  end

  def review_count
    @reviews.count 
  end
end