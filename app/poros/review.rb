class Review
  attr_reader :author,
              :rating,
              :content
              
  def initialize(review_info)
    @author = review_info[:author]
    @rating = review_info[:author_details][:rating]
    @content = review_info[:content]
  end
end