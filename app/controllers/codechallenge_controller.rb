class CodechallengeController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user.codechallenge_id.nil?
      @codechallenge = Codechallenge.first
    else
      @codechallenge = Codechallenge.nextChallenge(current_user.codechallenge_id)
    end
  end

  def update
      attempt = params[:codechallenge_attempt]
      @codechallenge = Codechallenge.find(params[:id])

      @execute_result = @codechallenge.compare_problem_to attempt
      if @execute_result == true
        @eval_result = @codechallenge.eval_and_run_test_code attempt
        if @eval_result.match(/true/).present?
            @execute_result = "Congratz! Let's try the next challenge :)"
            current_user.setChallenge(@codechallenge)
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
