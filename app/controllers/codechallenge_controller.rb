class CodechallengeController < ApplicationController

  def index
    @codechallenge = Codechallenge.first
  end

  def update
      current_id = params[:id]
      attempt = params[:codechallenge_attempt]
      @codechallenge = Codechallenge.find(current_id)

      @execute_result = @codechallenge.compare_problem_to attempt

      if @execute_result == "Syntax OK"
        @codechallenge.nextChallenge
      else
        @codechallenge.problem = attempt
      end
    render :index
  end

  def show
    redirect_to :action => :index
  end
end
