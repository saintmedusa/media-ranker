class VotesController < ApplicationController

  def create
    user_id = session[:current_user_id]
    work_id = params[:format]
    @vote = Vote.new(user_id: user_id, work_id: work_id)
    if @vote.save
      flash[:success] = "Successfully upvoted"
    else
      error = "Upvote failed: "
      if session[:current_user_id] == nil
        flash[:error] = error + "you must login first"
      else
        flash[:error] = error + "already voted on this work"
      end
    end
    redirect_back(fallback_location: root_path)
  end

end
