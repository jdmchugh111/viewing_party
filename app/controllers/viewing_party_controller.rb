class ViewingPartyController < ApplicationController
  def new
    @user_id = params[:user_id]
    @movie_id = params[:movie_id]
    facade = MoviesFacade.new(params[:movie_id])
    @movie = facade.movie
  end

  def create
    @new_party = ViewingParty.new(party_params)
    if @new_party.save 
      UserParty.create!(viewing_party: @new_party, user: User.find(params[:user_id]), host: true)
      user_1 = User.find_by(email: params[:guest_email_1])
      if user_1 != nil
        UserParty.create!(viewing_party: @new_party, user: user_1, host: false)
      end
      user_2 = User.find_by(email: params[:guest_email_2])
      if user_2 != nil
        UserParty.create!(viewing_party: @new_party, user: user_2, host: false)
      end
      user_3 = User.find_by(email: params[:guest_email_3])
      if user_3 != nil
        UserParty.create!(viewing_party: @new_party, user: user_3, host: false)
      end
        redirect_to user_path(params[:user_id])
    else
      flash.notice = "Duration, Date, and Time must be entered"
      redirect_to new_user_movie_viewing_party_path(params[:user_id], params[:movie_id])
    end
  end

  def show
    facade = MoviesFacade.new(params[:movie_id])
    @movie = facade.movie
  end

  private

    def party_params
      params.permit(:duration, :date, :start_time)
    end
end