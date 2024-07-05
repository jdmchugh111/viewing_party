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
      check_and_add_user(params[:guest_email_1])
      check_and_add_user(params[:guest_email_2])
      check_and_add_user(params[:guest_email_3])
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
      params.permit(:duration, :date, :start_time, :movie_id)
    end

    def check_and_add_user(guest_email)
      user = User.find_by(email: guest_email)
      if user != nil
        UserParty.create!(viewing_party: @new_party, user: user, host: false)
      end
    end
end