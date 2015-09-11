class CodechallengeController < ApplicationController

  def index
    @codechallenge = Codechallenge.first
  end

  def update
      current_id = params[:id]
      attempt = params[:codechallenge_attempt]
      @codechallenge = Codechallenge.find(current_id)
      
      @execute_result = @codechallenge.compare_problem_to attempt
      if @execute_result == true
        @eval_result = @codechallenge.eval_and_run_test_code attempt
        if @eval_result.match(/true/).present?
            @execute_result = "Congratz! Let's try the next challenge :)"
            @codechallenge = @codechallenge.nextChallenge
        else
            @codechallenge.problem = attempt
            @execute_result = "Execute result: #{@eval_result}"
        end
      else
        @codechallenge.problem = attempt
      end
    render :index
  end

  def show
    redirect_to :action => :index
  end
end
