class VotesController < ApplicationController

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      flash.now[:success] = "Successfully upvoted"
      head :created
      return
    else
      error = "Upvote failed: "
      if session[:current_user_id] == nil
        flash.now[:error] = error + "you must login first"
      else
        flash.now[:error] = error + "already voted on this work"
      end
      head :bad_request
      return
    end
  end

  private
  def vote_params
    return params.require(:vote).permit(:user_id)#,work_id)
  end
end
