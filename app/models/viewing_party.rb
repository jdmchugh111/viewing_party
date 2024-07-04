class ViewingParty < ApplicationRecord
   validates_presence_of :duration, :date, :start_time
   has_many :user_parties
   has_many :users, through: :user_parties

   def find_host
      users.where("user_parties.host = true").first
   end

   def movie_by_id
      movie_id = self.movie_id
      facade = MoviesFacade.new(movie_id)
      facade.movie
   end
end
