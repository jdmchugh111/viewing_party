class AddMovieIdToViewingParties < ActiveRecord::Migration[7.1]
  def change
    add_column :viewing_parties, :movie_id, :bigint
  end
end
